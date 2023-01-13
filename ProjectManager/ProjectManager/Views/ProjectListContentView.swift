//
//  ProjectListContentView.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

final class ProjectListContentView: UIView, UIContentView {
    // MARK: - Properties
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    let descriptionLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = Constants.numberOfDescriptionLines
        return label
    }()
    private let dueDateLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.smallSpacing
        stackView.backgroundColor = ProjectColor.cellBackground.color
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: Constants.defaultSpacing,
                                                                     leading: Constants.defaultSpacing,
                                                                     bottom: Constants.defaultSpacing,
                                                                     trailing: Constants.defaultSpacing)
        return stackView
    }()

    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }

    // MARK: - Configure
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        titleLabel.text = configuration.title
        descriptionLabel.text = configuration.description
        dueDateLabel.attributedText = configuration.dueDateAttributedText
    }

    private func configureHierarchy() {
        [titleLabel, descriptionLabel, dueDateLabel].forEach(stackView.addArrangedSubview(_:))
        addSubview(stackView)
        let spacing = Constants.smallSpacing
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
    }
}

// MARK: - Configuration
extension ProjectListContentView {
    struct Configuration: UIContentConfiguration {
        var title: String?
        var description: String?
        var dueDateAttributedText: NSAttributedString?

        func makeContentView() -> UIView & UIContentView {
            return ProjectListContentView(configuration: self)
        }

        func updated(for state: UIConfigurationState) -> ProjectListContentView.Configuration {
            return self
        }
    }
}
