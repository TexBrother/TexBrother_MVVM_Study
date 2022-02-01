//
//  EmailTableViewCell.swift
//  TexBrother_MVVM_Study
//
//  Created by hansol on 2022/02/02.
//

import UIKit

import SnapKit
import Then

// MARK: - EmailTableViewCell

final class EmailTableViewCell: UITableViewCell {

    // MARK: - Components
    
    private let emailLabel = UILabel()
    
    // MARK: - Variables
    
    
    // MARK: - LifeCycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension EmailTableViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        contentView.backgroundColor = .clear
        contentView.add(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - General Helpers
    
    func bind(model : EmailModel) {
        self.emailLabel.setupLabel(
            text: model.content,
            color: model.textColor,
            font: .systemFont(ofSize: 11.adjusted, weight: .medium)
        )
    }
}
