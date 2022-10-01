//
//  CardSectionView.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import UIKit
import Then

final class CardSectionView: UIView {
    private enum Const {
        static let stackViewSpacing = 8.0
        static let delete = "삭제"
    }

    private let cardType: CardType
    private let viewModel: CardViewModelProtocol
    private let coordinator: CoordinatorProtocol

    lazy var headerView = CardHeaderView(cardType: cardType).then {
        $0.backgroundColor = .systemGray5
    }

    let tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(CardListTableViewCell.self,
                    forCellReuseIdentifier: CardListTableViewCell.reuseIdentifier)
        $0.backgroundColor = .systemGray6
        $0.separatorStyle = .none
    }
    
    private let rootStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = Const.stackViewSpacing
        $0.backgroundColor = .systemGray6
    }
    
    init(coordinator: CoordinatorProtocol,
         viewModel: CardViewModelProtocol,
         type: CardType) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.cardType = type

        super.init(frame: .zero)
        setupDefault()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupDefault() {
        addSubview(rootStackView)

        tableView.delegate = self
        
        rootStackView.addArrangedSubview(headerView)
        rootStackView.addArrangedSubview(tableView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: TableView Action

extension CardSectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        didSelectCell(cardType,
                      at: indexPath.row)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: Const.delete) { [weak self] (_, _, completionHandler: @escaping (Bool) -> Void) in
            guard let self = self else { return }

            self.viewModel.delete(self.cardType,
                                  at: indexPath.row)

            completionHandler(true)
        }

        delete.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [delete])
    }

    private func didSelectCell(_ cardType: CardType,
                               at indexPath: Int) {
        switch cardType {
        case .todo:
            assignToDetailViewController(viewModel.todoList?[indexPath])
        case .doing:
            assignToDetailViewController(viewModel.doingList?[indexPath])
        case .done:
            assignToDetailViewController(viewModel.doneList?[indexPath])
        }
    }

    private func assignToDetailViewController(_ data: CardModel?) {
        if let data = data {
            coordinator.presentDetailViewController(data)
        }
    }
}
