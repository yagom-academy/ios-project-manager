//
//  CardListTableViewCell.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import UIKit

import Then

final class CardListTableViewCell: UITableViewCell {
  private enum UISettings {
    static let intervalFromContentView = 16.0
    static let intervalBetweenLabels = 16.0
    static let numberOfLinesOfDescriptionLabel = 3
  }
  
  static let identifier = "CardListTableViewCell"
  
  private let titleLabel = UILabel().then {
    $0.textColor = .label
    $0.lineBreakMode = .byTruncatingTail
    $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    $0.font = .preferredFont(forTextStyle: .title3)
  }
  private let descriptionLabel = UILabel().then {
    $0.textColor = .secondaryLabel
    $0.numberOfLines = UISettings.numberOfLinesOfDescriptionLabel
    $0.font = .preferredFont(forTextStyle: .body)
  }
  private let deadlineDateLabel = UILabel().then {
    $0.textColor = .label
    $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    $0.font = .preferredFont(forTextStyle: .body)
  }
  private lazy var containerStackView = UIStackView(
    arrangedSubviews: [titleLabel, descriptionLabel, deadlineDateLabel]
  ).then {
    $0.axis = .vertical
    $0.spacing = UISettings.intervalBetweenLabels
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureSubViews()
    configureLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    descriptionLabel.text = nil
    deadlineDateLabel.text = nil
  }
  
  func setup(card: Card) {
    titleLabel.text = card.title
    descriptionLabel.text = card.description
    deadlineDateLabel.text = setDeadlineDateToString(card.deadlineDate)
    deadlineDateLabel.textColor = isOverdue(card: card) ? .systemRed : .label
  }
  
  private func setDeadlineDateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    return formatter.string(from: date)
  }

  private func isOverdue(card: Card) -> Bool {
    return (card.cardType == .todo || card.cardType == .doing) && Date() >= card.deadlineDate
  }
}

// MARK: - UI Configuration

extension CardListTableViewCell {
  private func configureSubViews() {
    contentView.addSubview(containerStackView)
  }
  
  private func configureLayouts() {
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: UISettings.intervalFromContentView
      ),
      containerStackView.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -UISettings.intervalFromContentView
      ),
      containerStackView.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: UISettings.intervalFromContentView
      ),
      containerStackView.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -UISettings.intervalFromContentView
      ),
    ])
  }
}
