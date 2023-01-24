//
//  ProcessStackView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/11.
//

import UIKit

final class ProcessView: UIStackView {
    typealias DataSource = UITableViewDiffableDataSource<Section, Plan>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Plan>
    
    enum Section {
        case main
    }
    
    private enum UIConstant {
        static let headerViewHeight = 70.0
        static let stackViewSpacing = 1.0
        static let headerStackViewSpacing = 20.0
        static let topBottomValue = 10.0
        static let leadingValue = 20.0
        static let countLabelWidth = 30.0
        static let headerSectionHeight = 7.0
        static let deleteSwipeTitle = "Delete"
    }

    private lazy var dataSource = configureDataSource()
    private let viewModel: ProcessViewModel
    
    private let titleLabel = UILabel(fontStyle: .largeTitle)
    private let countLabel = UILabel(fontStyle: .title3)
    
    private lazy var headerStackView = UIStackView(
        views: [titleLabel, countLabel],
        axis: .horizontal,
        alignment: .center,
        distribution: .fill,
        spacing: UIConstant.headerStackViewSpacing
    )
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(headerStackView)
        return view
    }()
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    weak var gestureDelegate: GestureManageable?
    weak var selectDataDelegate: EventManageable?
    
    init(viewModel: ProcessViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupBind()
        setupLabel()
        setupTableView()
        setupCosntraint()
        setupGesture()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBind() {
        viewModel.bindDatas(handler: { [weak self] datas in
            self?.countLabel.text = String(datas.count)
            self?.applySnapshot(data: datas, animating: true)
        })
    }
    
    func updateView(_ data: [Plan]) {
        viewModel.updateDatas(data: data)
    }
}

// MARK: - Diffable DataSource, Snapshot
extension ProcessView {
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, plan in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProcessTableViewCell.identifier,
                for: indexPath
            ) as? ProcessTableViewCell else {
                let errorCell = UITableViewCell()
                return errorCell
            }
            
            cell.setupViewModel(CellViewModel(data: plan))
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot(data: [Plan], animating: Bool) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: animating)
    }
}

// MARK: - TableView Delegate
extension ProcessView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstant.headerSectionHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDataDelegate?.shareUpdateEvent(
            process: viewModel.process,
            index: indexPath.row
        )
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(
            style: .normal,
            title: UIConstant.deleteSwipeTitle
        ) { [weak self] _, _, _ in
            guard let self = self else { return }
            self.selectDataDelegate?.shareDeleteEvent(
                process: self.viewModel.process,
                index: indexPath.row
            )
        }
        
        delete.backgroundColor = .red
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
}

// MARK: - Long Press Gesture
extension ProcessView {
    private func setupGesture() {
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPressGesture)
        )
        
        longPress.delaysTouchesBegan = true
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc func longPressGesture(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        gestureDelegate?.shareLongPress(
            process: viewModel.process,
            view: cell,
            index: indexPath.row
        )
    }
}

// MARK: - UI Configuration
extension ProcessView {
    private func setupView() {
        titleLabel.text = "\(viewModel.process)"
        [headerView, tableView].forEach(addArrangedSubview(_:))
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = UIConstant.stackViewSpacing
        headerView.backgroundColor = .systemGray5
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabel() {
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .black
        countLabel.layer.masksToBounds = true
        countLabel.layer.cornerRadius = UIConstant.countLabelWidth * 0.5
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.backgroundColor = .systemGray5
        tableView.register(
            ProcessTableViewCell.self,
            forCellReuseIdentifier: ProcessTableViewCell.identifier
        )
    }
    
    private func setupCosntraint() {
        let headerSafeArea = headerView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: UIConstant.headerViewHeight),
            
            headerStackView.topAnchor.constraint(
                equalTo: headerSafeArea.topAnchor,
                constant: UIConstant.topBottomValue
            ),
            headerStackView.leadingAnchor.constraint(
                equalTo: headerSafeArea.leadingAnchor,
                constant: UIConstant.leadingValue
            ),
            headerStackView.bottomAnchor.constraint(
                equalTo: headerSafeArea.bottomAnchor,
                constant: -UIConstant.topBottomValue
            ),
            
            countLabel.widthAnchor.constraint(equalToConstant: UIConstant.countLabelWidth),
            countLabel.heightAnchor.constraint(equalTo: countLabel.widthAnchor)
        ])
    }
}
