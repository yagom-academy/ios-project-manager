//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

final class HeaderView: UIView {
    private enum UIConstraint {
        static let countLabelWidth = 30.0
        static let stackViewSpacing = 20.0
        static let topValue = 10.0
        static let bottomValue = -10.0
        static let leadingValue = 20.0
        static let trailingValue = -20.0
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.font = .preferredFont(forTextStyle: .title3)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = UIConstraint.countLabelWidth * 0.5
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = UIConstraint.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(process: Process) {
        super.init(frame: .zero)
        titleLabel.text = process.titleValue
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView {
    private func setupView() {
        addSubview(stackView)
    }
    
    private func setupConstraint() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: UIConstraint.topValue
            ),
            stackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: UIConstraint.leadingValue
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstraint.bottomValue
            ),
            
            countLabel.widthAnchor.constraint(equalToConstant: UIConstraint.countLabelWidth),
            countLabel.heightAnchor.constraint(equalTo: countLabel.widthAnchor)
        ])
    }
}
