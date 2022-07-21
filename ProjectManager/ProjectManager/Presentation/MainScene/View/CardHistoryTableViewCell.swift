//
//  CardHistoryTableViewCell.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/21.
//

import UIKit

import Then

final class CardHistoryTableViewCell: UITableViewCell {
  private enum UISettings {
    static let intervalBetweenLabels = 8.0
    static let intervalFromContentView = 16.0
  }
  
  static let identifier = "CardHistoryTableViewCell"
  
  private let titleLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .body)
  }
  private let actionTypeLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .caption2)
    $0.textColor = .systemBackground
  }
  private let informationLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .caption2)
    $0.textColor = .secondaryLabel
  }
  private let actionTimeLabel = UILabel().then {
    $0.font = .preferredFont(forTextStyle: .callout)
    $0.textColor = .secondaryLabel
  }
  private let container = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .leading
    $0.spacing = UISettings.intervalBetweenLabels
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureSubviews()
    configureLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    actionTypeLabel.text = nil
    informationLabel.text = nil
    actionTimeLabel.text = nil
  }
  
  func setup(history: CardHistoryViewModelItem) {
    titleLabel.text = history.card.title
    actionTypeLabel.text = history.actionType.description
    actionTimeLabel.text = history.actionTimeString
    informationLabel.text = history.informationString
    setActionTypeLabelColor(history: history)
  }
  
  private func setActionTypeLabelColor(history: CardHistoryViewModelItem) {
    switch history.actionType {
    case .create:
      actionTypeLabel.backgroundColor = .systemGreen
    case .update:
      actionTypeLabel.backgroundColor = .systemOrange
    case .delete:
      actionTypeLabel.backgroundColor = .systemRed
    case .move(_):
      actionTypeLabel.backgroundColor = .systemBlue
    }
  }
}

// MARK: - UI Configuration

extension CardHistoryTableViewCell {
  private func configureSubviews() {
    contentView.addSubview(container)
    
    let informationContainer = UIStackView(arrangedSubviews: [actionTypeLabel, informationLabel])
    informationContainer.axis = .horizontal
    informationContainer.spacing = UISettings.intervalBetweenLabels  
    [titleLabel, informationContainer, actionTimeLabel].forEach { container.addArrangedSubview($0) }
  }
  
  private func configureLayouts() {
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: UISettings.intervalFromContentView
      ),
      container.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -UISettings.intervalFromContentView
      ),
      container.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: UISettings.intervalFromContentView
      ),
      container.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -UISettings.intervalFromContentView
      ),
    ])
  }
}
