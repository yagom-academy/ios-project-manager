//
//  PlanViewController.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/25.
//

import UIKit
import Combine

final class PlanViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, Plan>?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    private let header: HeaderView
    private let viewModel: PlanViewModel
    
    init(headerName: String, viewModel: PlanViewModel) {
        self.header = HeaderView(text: headerName, frame: .zero)
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        let height: CGFloat = 60
        self.header.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = header
        tableView.delegate = self
        
        setUpTableView()
        configureTableView()
        setUpBindings()
        setUpLongPressGesture()
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureTableView() {
        dataSource = UITableViewDiffableDataSource<Section, Plan>(tableView: tableView) { [unowned self] _, indexPath, _ in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PlanTableViewCell else { return UITableViewCell() }
            
            let plan = viewModel.read(at: indexPath)
            cell.configureCell(with: plan)
            
            return cell
        }
    }
    
    private func createSnapshot(_ plans: [Plan]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Plan>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(plans)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setUpBindings() {
        bindPlan()
        bindListCount()
    }
    
    private func bindPlan() {
        viewModel.$plan
            .receive(on: DispatchQueue.main)
            .sink { [weak self] plans in
                self?.createSnapshot(plans)
            }
            .store(in: &cancellables)
    }
    
    private func bindListCount() {
        viewModel.$plan
            .map { String($0.count) }
            .sink { [weak self] in
                self?.updatePlanCount($0)
            }
            .store(in: &cancellables)
    }
    
    private func updatePlanCount(_ count: String) {
        header.changeCount(count)
    }
}

extension PlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "delete") { [weak self] (_, _, _) in
            guard let plan = self?.viewModel.read(at: indexPath) else { return }
            
            self?.viewModel.delete(plan)
        }
        deleteAction.backgroundColor = .red

        return  UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let planManagerViewController = parent as? PlanManagerViewController else { return }
        let plan = viewModel.read(at: indexPath)

        let plusTodoViewModel = PlusTodoViewModel()
        plusTodoViewModel.addPlan(plan)
        
        let plusTodoViewController = PlusTodoViewController(plusTodoViewModel: plusTodoViewModel, mode: .edit)
        plusTodoViewController.delegate = planManagerViewController
        present(plusTodoViewController, animated: false)
    }
}

extension PlanViewController: UIGestureRecognizerDelegate {
    private func setUpLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self
        longPressGesture.delaysTouchesBegan = true

        tableView.addGestureRecognizer(longPressGesture)
    }

    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        guard let tableView = gestureRecognizer.view as? UITableView else { return }

        if gestureRecognizer.state == .began {
            guard let indexPath = tableView.indexPathForRow(at: location) else { return }

            UIView.animate(withDuration: 0.2) { [weak self] in
                if let cell = tableView.cellForRow(at: indexPath) as? PlanTableViewCell {
                    self?.manageAction(cell)
                }
            }
        }
    }

    private func manageAction(_ cell: PlanTableViewCell) {
        let firstState = viewModel.moveToFirst
        let secondState = viewModel.moveToSecond
        
        showActionSheet(firstState, secondState, cell)
    }

    private func showActionSheet(_ fristActionState: State, _ secondActionState: State, _ cell: PlanTableViewCell) {
        let firstActionTitle = viewModel.firstActionTitle
        let secondActionTitle = viewModel.secondActionTitle
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let firstAction = UIAlertAction(title: firstActionTitle, style: .default) { [weak self] _ in
            self?.changePlan(at: cell, to: fristActionState)
        }
        
        let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { [weak self] _ in
            self?.changePlan(at: cell, to: secondActionState)
        }

        alert.addAction(firstAction)
        alert.addAction(secondAction)

        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = cell
            popoverPresentationController.sourceRect = cell.bounds
            popoverPresentationController.permittedArrowDirections = .up
        }

        present(alert, animated: true)
    }

    private func changePlan(at cell: PlanTableViewCell, to new: State) {
        guard let plan = cell.fetchCellPlan()  else { return }
        
        viewModel.changeState(plan: plan, state: new)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
