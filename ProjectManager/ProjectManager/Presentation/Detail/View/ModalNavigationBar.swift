//
//  ModalNavigationBar.swift
//  ProjectManager
//
//  Created by Tiana on 2022/07/26.
//

import UIKit

final class ModalNavigationBar: UIView {
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    let modalTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpContents()
        setUpLayout()
        setUpAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContents() {
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(leftButton)
        baseStackView.addArrangedSubview(modalTitle)
        baseStackView.addArrangedSubview(rightButton)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setUpAttribute() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
    }
}
