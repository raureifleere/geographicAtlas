//
//  SkeletonViewCell.swift
//  geographicAtlasInternship
//
//  Created by Bibisara Kenesova on 17.05.2023.
//

import Foundation
import UIKit

class SkeletonViewCell: UITableViewCell {
    
    let flagView = UIView()
    let titleView = UIView()
    let subtitleView = UIView()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [flagView, titleView, subtitleView].forEach { view in
            view.backgroundColor = .systemGray5
            view.clipsToBounds = true
            view.layer.cornerRadius = 16
        }
        
        contentView.addSubview(flagView)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        flagView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.size.equalTo(CGSize(width: 82, height: 52))
        }
        
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(subtitleView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(flagView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}
