//
//  CardHistoryTableViewCell.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/25.
//

import UIKit
import Then

final class CardHistoryTableViewCell: UITableViewCell, ReuseIdentifying {
    private let rootScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [descriptionLabel, dateLabel]).then {
            $0.axis = .vertical
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.setContentHuggingPriority(.defaultHigh,
                                     for: .vertical)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let dateLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .callout)
        $0.textColor = .systemGray3
        $0.setContentHuggingPriority(.defaultHigh,
                                     for: .vertical)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefault()
        configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setupDefault() {
        contentView.addSubview(rootScrollView)
        rootScrollView.addSubview(rootStackView)
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            rootScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            rootScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            rootScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            rootScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    func bindUI(viewModel: CardHistoryItemViewModel) {
        descriptionLabel.text = viewModel.title
        dateLabel.text = viewModel.date
    }
}
