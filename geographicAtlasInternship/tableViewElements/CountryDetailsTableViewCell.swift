//
//  CountryDetailsTableViewCell.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import UIKit
import SnapKit

class CountryDetailsTableViewCell: UITableViewCell {
    
    private lazy var pointListImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    func titleConfigure(with text: String) {
        titleLabel.text = text
    }
    
    func subtitleConfigure(with text: String) {
        subtitleLabel.text = text
    }

    var onSubtitleTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTap() {
        onSubtitleTap?()
    }
}

//MARK: - Setup views and constraints methods

private extension CountryDetailsTableViewCell {
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(pointListImage)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        subtitleLabel.isUserInteractionEnabled = true
        subtitleLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupConstraints() {
        pointListImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 8, height: 8))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(pointListImage.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(pointListImage.snp.trailing).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.bottom.equalToSuperview().inset(4)
        }
    }
}
