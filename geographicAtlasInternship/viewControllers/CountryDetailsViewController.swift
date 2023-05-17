//
//  CountryDetailsViewController.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import UIKit
import SnapKit

class CountryDetailsViewController: UIViewController {
    
    let cca2: String
    let name: String
    var apiCaller = CountryDetailsAPICaller()
    var model: CountryListModel?
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(CountryDetailsTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.countryDetailsTableViewCell)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    func configureFlag(with urlString: String) {
        guard let url = URL(string: urlString) else { fatalError("Incorrect link for flag") }
        DispatchQueue.main.async {
            self.flagImageView.kf.setImage(with: url)
        }
    }
    
    init(name: String, cca2: String) {
        self.name = name
        self.cca2 = cca2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        navigationItem.backButtonTitle = nil
        navigationItem.title = name
        
        apiCaller.delegate = self
        apiCaller.fetchRequest(cca2: cca2)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self

        setupViews()
        setupConstraints()
    }
}

extension CountryDetailsViewController: CountryDetailsAPICallerDelegate {
    func didUpdateCountry(with country: CountryListModel) {
        model = country
        
        DispatchQueue.main.async {
            self.configureFlag(with: country.flags.png)
            self.mainTableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {}
}

//MARK: Table View Data Source methods

extension CountryDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard model != nil else { return 0 }
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryDetailsTableViewCell, for: indexPath) as? CountryDetailsTableViewCell,
            let country = model
        else { return UITableViewCell() }
        cell.backgroundColor = .systemBackground
        switch indexPath.row {
        case 0:
            cell.titleConfigure(with: "Region: ")
            cell.subtitleConfigure(with: country.subregion ?? "")
        case 1:
            cell.titleConfigure(with: "Capital: ")
            cell.subtitleConfigure(with: country.capital?.first ?? "")
        case 2:
            cell.titleConfigure(with: "Capital coordinates: ")
            cell.subtitleConfigure(with: country.capitalInfo.latlng?.map { String($0) }.joined(separator: ", ") ?? "")
            cell.onSubtitleTap = {
                guard let url = URL(string: country.maps.openStreetMaps) else { return }
                UIApplication.shared.open(url)
            }
        case 3:
            cell.titleConfigure(with: "Population: ")
            cell.subtitleConfigure(with: String(Int(country.population)))
        case 4:
            cell.titleConfigure(with: "Area: ")
            cell.subtitleConfigure(with: "\(String(Int(country.area))) km2")
        case 5:
            cell.titleConfigure(with: "Currency: ")
            // Это можно вынести в отдельную функцию, тк используется еще в списке стран
            if let currencies = country.currencies {
                var currenciesArray = [String]()
                for (_, value) in currencies {
                    var currencyStr = ""
                    if let name = value.name {
                        currencyStr.append(name)
                    }
                    if let symbol = value.symbol {
                        currencyStr.append(" (\(symbol))")
                    }
                    if let code = value.code {
                        currencyStr.append(" (\(code))")
                    }
                    currenciesArray.append(currencyStr)
                }
                cell.subtitleConfigure(with: currenciesArray.joined(separator: ", ") )
                
            }
        case 6:
            cell.titleConfigure(with: "Timezones: ")
            cell.subtitleConfigure(with: country.timezones.joined(separator: ", ") )
        default:
            cell.titleConfigure(with: "")
            cell.subtitleConfigure(with: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return flagImageView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        193
    }
}

//MARK: Table View Delegate methods

extension CountryDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

//MARK: - Setup views and constraints methods

private extension CountryDetailsViewController {
    func setupViews() {
        view.addSubview(mainTableView)
    }
    
    func setupConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
