//
//  HistoryCollectionViewCell.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/28.
//

import UIKit

final class HistoryCollectionViewCell: UICollectionViewCell, Identifierable {
  let viewModel = HistoryCollectionViewModel()
  
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
    label.font = .preferredFont(forTextStyle: .title2)
    label.setContentHuggingPriority(.required, for: .vertical)
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    
    label.setContentHuggingPriority(.defaultLow, for: .vertical)
    label.textColor = .systemGray4
    return label
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
    mainStackView.addArrangedSubviews([titleLabel, dateLabel])
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: topAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  func updateUIDate(_ memento: Memento) {
    titleLabel.text = viewModel.makeTitle(memento)
    dateLabel.text = Date.makeDate(memento.todo.date)
  }
}
