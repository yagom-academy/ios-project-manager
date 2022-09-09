//
//  CardSectionView.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import UIKit
import Then

final class CardSectionView: UIView {
    private let rootStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
    }
    
    var headerView: CardListHeaderView?
    let tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 130
        $0.tableFooterView = UIView(frame: .zero)
        $0.register(CardListTableViewCell.self,
                    forCellReuseIdentifier: CardListTableViewCell.identifier)
    }
    
    init(type: CardType) {
        self.headerView = CardListHeaderView(cardType: type)
        super.init(frame: .zero)
        addSubViews()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubViews() {
        self.addSubview(rootStackView)
        
        guard let headerView = headerView else { return }
        
        rootStackView.addArrangedSubview(headerView)
        rootStackView.addArrangedSubview(tableView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
