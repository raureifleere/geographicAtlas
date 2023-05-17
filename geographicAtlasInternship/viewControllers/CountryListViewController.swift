//
//  ViewController.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CountryListViewController: UIViewController {
    
    var apiCaller = CountryListAPICaller()
    var continents: [ContinentModel] = []
    var isLoaded = false
    
    var continentsList = Constants.Continents.allCases
    
    private lazy var countryListTableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.backgroundColor = .systemBackground
        tableview.register(CountryListTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.countryListTableViewCell)
        tableview.separatorStyle = .none
        tableview.allowsMultipleSelection = true
        tableview.showsVerticalScrollIndicator = false
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        countryListTableView.dataSource = self
        countryListTableView.delegate = self
        apiCaller.delegate = self
        apiCaller.fetchRequest()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Worlds countries"
        
        setupViews()
        setupConstraints()
    }
}

//MARK: - API Caller delegate methods

extension CountryListViewController: CountryListAPICallerDelegate {
    func didUpdateCountryList(with countryList: [CountryListModel]) {
        var map: [String: [CountryListModel]] = [:]
        
        for country in countryList {
            guard let name = country.continents.first else { continue }
            map[name, default: []].append(country)
        }
        
        var continents: [ContinentModel] = []
        
        for (key, value) in map {
            continents.append(.init(name: key, countries: value))
        }
        
        self.continents = continents.sorted(by: { $0.name < $1.name })
        self.isLoaded = true
        
        DispatchQueue.main.async {
            self.countryListTableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Failed with: ", error)
    }
}

//MARK: countryListTableView DataSource methods

extension CountryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard isLoaded else { return 5 }
        return continents.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard isLoaded else { return nil }
        let view = SectionHeaderView()
        view.configure(with: continents[section].name)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isLoaded else { return 1 }
        guard section < continents.count else { return 0 }
        return continents[section].countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard isLoaded else {
            return SkeletonViewCell()
        }
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryListTableViewCell, for: indexPath) as? CountryListTableViewCell,
            indexPath.section < continents.count,
            indexPath.row < continents[indexPath.section].countries.count
        else { return UITableViewCell() }
        
        cell.backgroundColor = .systemBackground
        
        let country = continents[indexPath.section].countries[indexPath.row]
        cell.expandConfigure(country.isExpanded)
        cell.titleConfigure(with: country.name.common)
        cell.capitalConfigure(with: country.capital?.first)
        cell.imageConfigure(with: country.flags.png)
        cell.populationConfigure(with: String(Int(country.population)))
        cell.areaConfigure(with: String(Int(country.area)))
        
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
            cell.currenciesConfigure(with: currenciesArray.joined(separator: ", "))
        }
        
        cell.onLearnMoreButtonTap = { [weak self] in
            let vc = CountryDetailsViewController(name: country.name.common, cca2: country.cca2)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: countryListTableView Delegate methods

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard isLoaded else { return 72 }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        continents[indexPath.section].countries[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - Setup views and constraints methods

private extension CountryListViewController {
    func setupViews() {
        view.addSubview(countryListTableView)
    }
    
    func setupConstraints() {
        countryListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
