//
//  ProjectManagerCollectionViewCell.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/11.
//

import UIKit

final class ProjectManagerCollectionViewCell: UICollectionViewListCell {
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var bodyLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!

  override func updateConstraints() {
    super.updateConstraints()

    self.separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
      .isActive = true
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    self.titleLabel.text = nil
    self.bodyLabel.text = nil
    self.dateLabel.text = nil
    self.dateLabel.textColor = nil
  }

  func configure(title: String, body: String, date: Date) {
    let dateText = date.changeToString()
    self.titleLabel.text = title
    self.bodyLabel.text = body
    self.dateLabel.text = dateText
    checkDeadLine(date: dateText)
  }

  private func checkDeadLine(date: String) {
    if date.dateCompare(from: Date()) == .orderedAscending {
      self.dateLabel.textColor = .red
    }
  }
}
