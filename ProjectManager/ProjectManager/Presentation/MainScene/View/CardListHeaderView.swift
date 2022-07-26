//
//  CardListHeaderView.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import UIKit

import Then

final class CardListHeaderView: UIView {
  private enum UISettings {
    static let cardCountLabelWidth = 30.0
    static let intervalBetweenLabels = 16.0
    static let intervalFromSuperViews = 16.0
  }
  
  private let cardTitleLabel = UILabel().then {
    $0.textColor = .label
    $0.font = .preferredFont(forTextStyle: .largeTitle)
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  let cardCountLabel = UILabel().then {
    $0.backgroundColor = .label
    $0.font = .preferredFont(forTextStyle: .title3)
    $0.textColor = .systemBackground
    $0.textAlignment = .center
    $0.layer.cornerRadius = UISettings.cardCountLabelWidth * 0.5
    $0.layer.masksToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private lazy var containerStackView = UIStackView(
    arrangedSubviews: [cardTitleLabel, cardCountLabel]
  ).then {
    $0.alignment = .center
    $0.spacing = UISettings.intervalBetweenLabels
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  init(cardType: CardType) {
    super.init(frame: .zero)
    cardTitleLabel.text = cardType.description
    configureSubViews()
    configureLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI Configuration

extension CardListHeaderView {
  private func configureSubViews() {
    addSubview(containerStackView)
  }
  
  private func configureLayouts() {
    backgroundColor = .systemGray6
    
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: UISettings.intervalFromSuperViews
      ),
      containerStackView.bottomAnchor.constraint(
        equalTo: bottomAnchor,
        constant: -UISettings.intervalFromSuperViews * 0.5
      ),
      containerStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: UISettings.intervalFromSuperViews
      ),
      cardCountLabel.widthAnchor.constraint(
        equalToConstant: UISettings.cardCountLabelWidth
      ),
      cardCountLabel.widthAnchor.constraint(
        equalTo: cardCountLabel.heightAnchor
      )
    ])
  }
}
