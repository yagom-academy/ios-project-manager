//
//  ProjectManagerCollectionViewCell.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/11.
//

import UIKit

final class ProjectManagerCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var bodyLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!

  func configure(title: String, body: String, date: Date) {
    let dateText = Formatter.changeToString(from: date)
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
