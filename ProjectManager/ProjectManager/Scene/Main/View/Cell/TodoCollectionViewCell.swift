//
//  TodoCollectionViewCell.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.
//

import UIKit
import SwipeCellKit

final class TodoCollectionViewCell: SwipeCollectionViewCell, Identifiable {
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.backgroundColor = .systemBackground
    stackView.spacing = 5
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentHuggingPriority(.required, for: .vertical)
    label.font = .preferredFont(forTextStyle: .title2)
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentHuggingPriority(.defaultLow, for: .vertical)
    label.textColor = .systemGray
    label.font = .preferredFont(forTextStyle: .title3)
    label.numberOfLines = 3
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentHuggingPriority(.required, for: .vertical)
    return label
  }()
  
  lazy var longPress: UILongPressGestureRecognizer = {
    let longPress = UILongPressGestureRecognizer()
    longPress.minimumPressDuration = 0.5
    longPress.delaysTouchesBegan = true
    addGestureRecognizer(longPress)
    return longPress
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray5
    confitureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func confitureUI() {
    contentView.addSubview(mainStackView)
    mainStackView.addArrangedSubviews([titleLabel, contentLabel, dateLabel])
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
      contentLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10)
    ])
  }
  
  func updatePropertiesValue(_ todo: Todo) {
    titleLabel.text = todo.title
    contentLabel.text = todo.content
    if todo.date.timeIntervalSinceNow < Date.now.timeIntervalSinceNow {
      dateLabel.textColor = .systemRed
    }
    dateLabel.text = .nowDate(todo.date)
  }
}
