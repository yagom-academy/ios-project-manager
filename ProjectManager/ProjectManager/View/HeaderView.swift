//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Toy on 1/24/24.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - Property
    private let titleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(frame: CGRect, schedule: Schedule) {
        self.titleLabel.text = schedule.discription
        super.init(frame: frame)
        setupStackView()
        setupStackViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        self.addSubview(stackView)
    }
    
    private func setupStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
    
}
