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
    static let intervalConstant = 16.0
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
  
  init(cardType: CardType) {
    super.init(frame: .zero)
    cardTitleLabel.text = cardType.description
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI Configuration

extension CardListHeaderView {
  private func configureUI() {
    backgroundColor = .systemGray6
    let labels = [cardTitleLabel, cardCountLabel]
    let containerStackView = UIStackView(arrangedSubviews: labels)
    containerStackView.alignment = .center
    containerStackView.spacing = UISettings.intervalConstant
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerStackView)
    
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: UISettings.intervalConstant
      ),
      containerStackView.bottomAnchor.constraint(
        equalTo: bottomAnchor,
        constant: -UISettings.intervalConstant * 0.5
      ),
      containerStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: UISettings.intervalConstant
      ),
      cardCountLabel.widthAnchor.constraint(equalToConstant: UISettings.cardCountLabelWidth),
      cardCountLabel.widthAnchor.constraint(equalTo: cardCountLabel.heightAnchor)
    ])
  }
}
