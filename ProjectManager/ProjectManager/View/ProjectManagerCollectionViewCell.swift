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
    self.titleLabel.text = title
    self.bodyLabel.text = body
    self.dateLabel.text = date.description
  }
}
