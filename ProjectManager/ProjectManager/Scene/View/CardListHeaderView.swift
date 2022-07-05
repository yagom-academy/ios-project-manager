//
//  CardListHeaderView.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import UIKit
import Then

final class CardListHeaderView: UIView {
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
    $0.layer.cornerRadius = 15.0
    $0.layer.masksToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  init(cardTitle: String) {
    super.init(frame: .zero)
    cardTitleLabel.text = cardTitle
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    let labels = [cardTitleLabel, cardCountLabel]
    let containerStackView = UIStackView(arrangedSubviews: labels)
    containerStackView.alignment = .center
    containerStackView.spacing = 16.0
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerStackView)
    
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
      containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
      cardCountLabel.widthAnchor.constraint(equalToConstant: 30.0),
      cardCountLabel.widthAnchor.constraint(equalTo: cardCountLabel.heightAnchor)
    ])
  }
}
