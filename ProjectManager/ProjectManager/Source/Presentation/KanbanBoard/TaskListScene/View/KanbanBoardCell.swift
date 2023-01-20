//
//  KanbanBoardCell.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/19.
//

import UIKit

protocol KanbanBoardDelegate: AnyObject {
    func kanbanBoard(didSelectedAt indexPath: IndexPath)
    func kanbanBoard(didDeletedAt indexPath: IndexPath)
    func kanbanBoard(didLongPressedAt indexPath: IndexPath, rect: CGRect)
}

final class KanbanBoardCell: UICollectionViewCell, ReusableView {
    private enum Section {
        case main
    }
    
    private lazy var tasksDataSource: UITableViewDiffableDataSource = {
        return UITableViewDiffableDataSource<Section, Task>(
            tableView: tableView) { (tableView, indexPath, task) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier,
                                                           for: indexPath) as? TaskCell else { return nil }
                cell.configure(with: task)
            return cell
        }
    }()
    private lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                      action: #selector(longPressGesture))
        
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delaysTouchesBegan = true
        
        return longPressGestureRecognizer
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        
        return label
    }()
    private let countLabel: CircleLabel = {
        let label = CircleLabel()
        
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.backgroundColor = .black
        label.textColor = .white
        
        return label
    }()
    private let blankView = UIView()
    private let topStackView = UIStackView()
    private let tableView = UITableView(frame: .zero,
                                        style: .insetGrouped)
    private let contentStackView = UIStackView()
    private var state: Task.State? = nil
    private weak var delegate: KanbanBoardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tableView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tasks: [Task], state: Task.State, delegate: KanbanBoardDelegate) {
        self.state = state
        self.delegate = delegate
        titleLabel.text = "\(state.title)"
        countLabel.text = "\(tasks.count)"
        apply(with: tasks)
    }
    
    override func prepareForReuse() {
        state = nil
        delegate = nil
        titleLabel.text = nil
        countLabel.text = nil
    }
}

private extension KanbanBoardCell {
    func setUI() {
        let spacing: CGFloat = 8
        
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(countLabel)
        topStackView.addArrangedSubview(blankView)
        topStackView.axis = .horizontal
        topStackView.spacing = spacing
        
        contentStackView.addArrangedSubview(topStackView)
        contentStackView.addArrangedSubview(tableView)
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(contentStackView)
        
        titleLabel.setContentHuggingPriority(.defaultHigh,
                                             for: .horizontal)
        countLabel.setContentHuggingPriority(.defaultLow,
                                             for: .horizontal)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                  constant: spacing),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: spacing),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                       constant: -spacing),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                     constant: -spacing)
        ])
        
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func apply(with tasks: [Task]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(tasks)
        
        tasksDataSource.apply(snapShot)
    }
    
    @objc func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: tableView)
        if sender.state == .ended {
            guard let indexPath = tableView.indexPathForRow(at: point),
                  let originRect = tableView.frameInWindow(cellRowAt: indexPath),
                  let state = state else { return }
            let longPressedIndexPath = IndexPath(item: indexPath.row, section: state.rawValue)
            let rect = CGRect(x: originRect.midX, y: originRect.midY, width: 0, height: 0)
            delegate?.kanbanBoard(didLongPressedAt: longPressedIndexPath, rect: rect)
        }
    }
}

extension KanbanBoardCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let state = state {
            let selectedIndexPath = IndexPath(item: indexPath.row, section: state.rawValue)
            delegate?.kanbanBoard(didSelectedAt: selectedIndexPath)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "삭제") { [weak self] _, _, completion in
            guard let state = self?.state else { return completion(false) }
            let deletedIndexPath = IndexPath(item: indexPath.row, section: state.rawValue)
            self?.delegate?.kanbanBoard(didDeletedAt: deletedIndexPath)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
