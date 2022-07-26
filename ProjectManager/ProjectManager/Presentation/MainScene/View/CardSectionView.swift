//
//  CardSectionView.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/06.
//

import UIKit

import Then

final class CardSectionView: UIStackView {
  let headerView: CardListHeaderView
  let tableView = UITableView().then {
    $0.backgroundColor = .systemGray6
  }
  
  init(sectionType: CardType) {
    headerView = CardListHeaderView(cardType: sectionType)
    super.init(frame: .zero)
    configureSubViews()
    configureLayouts()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI Configuration

extension CardSectionView {
  private func configureSubViews() {
    addArrangedSubview(headerView)
    addArrangedSubview(tableView)
  }
  
  private func configureLayouts() {
    axis = .vertical
  }
}
