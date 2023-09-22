//
//  TitleView.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/22.
//

import UIKit

final class TitleView: UIView {
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "타이틀"
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        titleStackView.addArrangedSubview(titleLabel)
        addSubview(titleStackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            titleStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
