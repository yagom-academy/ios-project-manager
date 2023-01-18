//
//  TodoContentView.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/12.
//

import UIKit

final class TodoContentView: UIView, UIContentView {
    struct Configutation: UIContentConfiguration {
        var title: String?
        var body: String?
        var date: String?

        func makeContentView() -> UIView & UIContentView {
            return TodoContentView(configuration: self)
        }

        func updated(for state: UIConfigurationState) -> Configutation {
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
        label.numberOfLines = 3
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
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 32)
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
        if let configuration = configuration as? Configutation,
           let date = configuration.date {
            titleLabel.text = configuration.title
            bodyLabel.text = configuration.body
            dateLabel.text = configuration.date
            settingDateLabelTextColor(date: date)
        } else {
            titleLabel.text = "nil"
            bodyLabel.text = "nil"
            dateLabel.text = "nil"
        }
    }

    private func settingDateLabelTextColor(date: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let currentDate = formatter.string(from: Date())
        let currentDates = currentDate.replacingOccurrences(of: " ", with: "").components(separatedBy: ["."])
        let settingDates = date.replacingOccurrences(of: " ", with: "").components(separatedBy: ["."])
        let currentDateNumbers = currentDates.compactMap { Int($0) }
        let settingDateNumbers = settingDates.compactMap { Int($0) }
        let currentYear = currentDateNumbers[0]
        let currentMonth = currentDateNumbers[1]
        let currentDay = currentDateNumbers[2]
        let settingYear = settingDateNumbers[0]
        let settingMonth = settingDateNumbers[1]
        let settingDay = settingDateNumbers[2]

        if settingYear < currentYear {
            dateLabel.textColor = .systemRed
            return
        }

        if settingYear > currentYear {
            dateLabel.textColor = .black
            return
        }

        if settingYear == currentYear {
            if settingMonth < currentMonth {
                dateLabel.textColor = .systemRed
            }

            if settingMonth > currentMonth {
                dateLabel.textColor = .black
            }

            if settingMonth == currentMonth {
                if settingDay >= currentDay {
                    dateLabel.textColor = .black
                } else {
                    dateLabel.textColor = .systemRed
                }
            }
            return
        }
    }

    private func configureSubViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
