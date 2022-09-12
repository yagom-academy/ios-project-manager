//
//  TableHeaderView.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import UIKit

private enum Design {
    static let mainStackViewSpacing: CGFloat = 8
    static let mainStackViewLeadingAnchor: CGFloat = 8
    static let countLabelSize: CGFloat = 25
}

final class TableHeaderView: UIView {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis  = .horizontal
        stackView.spacing = Design.mainStackViewSpacing
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: Design.countLabelSize).isActive = true
        label.widthAnchor.constraint(equalToConstant: Design.countLabelSize).isActive = true
        label.font = .preferredFont(forTextStyle: .title3)
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = Design.countLabelSize / 2
        label.textAlignment = .center
        label.textColor = .white

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setItems(title: String?, count: String?) {
        titleLabel.text = title
        countLabel.text = count
    }
    
    private func commonInit() {
        configureView()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        [titleLabel, countLabel].forEach { mainStackView.addArrangedSubview($0) }
    }
    
    private func configureStactViewLayout() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor
                    .constraint(equalTo: self.topAnchor),
                mainStackView.bottomAnchor
                    .constraint(equalTo: self.bottomAnchor),
                mainStackView.leadingAnchor
                    .constraint(equalTo: self.leadingAnchor,
                                constant: Design.mainStackViewLeadingAnchor),
                mainStackView.trailingAnchor
                    .constraint(equalTo: self.trailingAnchor)
            ]
        )
    }
}
