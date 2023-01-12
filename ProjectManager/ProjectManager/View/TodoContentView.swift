//
//  TodoContentView.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/12.
//

import UIKit

class TodoContentView: UIView, UIContentView {
    struct Configutation: UIContentConfiguration {
        var title: String
        var body: String
        var date: String

        func makeContentView() -> UIView & UIContentView {
            return TodoContentView(configuration: self)
        }

        func updated(for state: UIConfigurationState) -> TodoContentView.Configutation {
            return self
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .black
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(configuration: UIContentConfiguration) {
        if let configuration = configuration as? Configutation {
            titleLabel.text = configuration.title
            bodyLabel.text = configuration.body
            dateLabel.text = configuration.date
        }
    }

    private func configureSubViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16)
        ])
    }

}
