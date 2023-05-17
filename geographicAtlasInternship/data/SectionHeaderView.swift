//
//  SectionHeaderView.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 16.05.2023.
//

import UIKit

final class SectionHeaderView: UIView {
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        regionLabel.text = text
    }
    
}

//MARK: - Setup views and constraints methods

private extension SectionHeaderView {
    func setupViews() {
        addSubview(regionLabel)
    }
    
    func setupConstraints() {
        regionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
