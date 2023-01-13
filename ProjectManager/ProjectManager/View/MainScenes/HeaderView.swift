//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

final class HeaderView: UIView {
    private enum UIConstant {
        static let countLabelWidth = 30.0
        static let stackViewSpacing = 20.0
        static let topValue = 10.0
        static let bottomValue = -10.0
        static let leadingValue = 20.0
        static let trailingValue = -20.0
    }
    
    private let titleLabel = UILabel(fontStyle: .largeTitle)
    let countLabel = UILabel(fontStyle: .title3)
    
    private lazy var stackView = UIStackView(
        views: [titleLabel, countLabel],
        axis: .horizontal,
        alignment: .center,
        distribution: .fill,
        spacing: UIConstant.stackViewSpacing
    )
    
    init(process: Process) {
        super.init(frame: .zero)
        titleLabel.text = process.titleValue
        setupView()
        setupLabel()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
extension HeaderView {
    private func setupView() {
        backgroundColor = .systemGray5
        addSubview(stackView)
    }
    
    private func setupLabel() {
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .black
        countLabel.layer.masksToBounds = true
        countLabel.layer.cornerRadius = UIConstant.countLabelWidth * 0.5
    }
    
    private func setupConstraint() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: UIConstant.topValue
            ),
            stackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: UIConstant.leadingValue
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstant.bottomValue
            ),
            
            countLabel.widthAnchor.constraint(equalToConstant: UIConstant.countLabelWidth),
            countLabel.heightAnchor.constraint(equalTo: countLabel.widthAnchor)
        ])
    }
}
