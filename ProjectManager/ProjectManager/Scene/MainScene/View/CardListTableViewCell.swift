//
//  CardListTableViewCell.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import UIKit
import Then

final class CardListTableViewCell: UITableViewCell {
  static let identifier = "CardListTableViewCell"
  
  private let titleLabel = UILabel().then {
    $0.textColor = .label
    $0.lineBreakMode = .byTruncatingTail
    $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    $0.font = .preferredFont(forTextStyle: .title3)
  }
  private let descriptionLabel = UILabel().then {
    $0.textColor = .secondaryLabel
    $0.numberOfLines = 3
    $0.font = .preferredFont(forTextStyle: .body)
  }
  private let deadlineDateLabel = UILabel().then {
    $0.textColor = .label
    $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    $0.font = .preferredFont(forTextStyle: .body)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
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
  
  private func configureUI() {
    let labels = [titleLabel, descriptionLabel, deadlineDateLabel]
    let containerStackView = UIStackView(arrangedSubviews: labels)
    containerStackView.axis = .vertical
    containerStackView.spacing = 8
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(containerStackView)
    
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
      containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
      containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
      containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
    ])
  }
}
