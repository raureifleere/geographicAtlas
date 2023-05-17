//
//  CountryListTableViewCell.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CountryListTableViewCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 16
        return stackView
    }()
    
    //main part
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemCyan
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var titleCountryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //expand part
    private lazy var expendableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var populSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var populationTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var areaSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var currSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Currencies:"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var currenciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Currencies:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn more", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = .systemGray6
        return button
    }()
    
    @objc func pressLearnMore() {
        onLearnMoreButtonTap?()
    }
    
    //Configure elements in cell
    var onLearnMoreButtonTap: (() -> Void)?
    
    func expandConfigure(_ isExpanded: Bool) {
        expendableView.isHidden = !isExpanded
        chevronImageView.image = (isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"))?.withRenderingMode(.alwaysTemplate)
    }
    
    func imageConfigure(with urlString: String) {
        guard let url = URL(string: urlString) else { fatalError("Incorrect link for flag") }
        DispatchQueue.main.async {
            self.flagImageView.kf.setImage(with: url)
        }
    }
    
    func titleConfigure(with title: String) {
        titleCountryLabel.text = title
    }
    
    func capitalConfigure(with title: String?) {
        capitalLabel.text = title
    }
    
    func populationConfigure(with population: String) {
        populationTextLabel.text = "\(population)"
    }
    
    func areaConfigure(with area: String) {
        areaLabel.text = "\(area) km2"
    }
    func currenciesConfigure(with currencies: String) {
        currenciesLabel.text = "\(currencies)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        expandConfigure(false)
    }
    
}

//MARK: - Setup views and constraints methods

private extension CountryListTableViewCell {
    func setupViews() {
        contentView.addSubview(stackView)
        [mainView, expendableView].forEach { stackView.addArrangedSubview($0) }
        
        mainView.addSubview(flagImageView)
        mainView.addSubview(titleCountryLabel)
        mainView.addSubview(capitalLabel)
        mainView.addSubview(chevronImageView)
        
        expendableView.addSubview(populSubtitleLabel)
        expendableView.addSubview(populationTextLabel)
        expendableView.addSubview(areaSubtitleLabel)
        expendableView.addSubview(areaLabel)
        expendableView.addSubview(currSubtitleLabel)
        expendableView.addSubview(currenciesLabel)
        expendableView.addSubview(learnMoreButton)
        
        learnMoreButton.addTarget(self, action: #selector(pressLearnMore), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        //main
        
        mainView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(72)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 82, height: 48))
        }
        
        titleCountryLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        capitalLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(10)
            make.top.equalTo(titleCountryLabel.snp.bottom)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleCountryLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        //expand
        expendableView.snp.remakeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(139)
        }
        
        populSubtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(90)
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        populationTextLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().offset(5)
            make.leading.equalTo(populSubtitleLabel.snp.trailing).offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        areaSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(populSubtitleLabel.snp.bottom).offset(5)
            make.width.equalTo(42)
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(populationTextLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
            make.leading.equalTo(areaSubtitleLabel.snp.trailing).offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        currSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(areaSubtitleLabel.snp.bottom).offset(5)
            make.width.equalTo(95)
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        currenciesLabel.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
            make.leading.equalTo(currSubtitleLabel.snp.trailing).offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(currenciesLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
