//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

class HeaderView: UIView {
    private enum UIConstraint {
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
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
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
            stackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: UIConstraint.trailingValue
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstraint.bottomValue
            )
        ])
    }
}
