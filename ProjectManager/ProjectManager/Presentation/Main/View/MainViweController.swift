//
//  MainViweController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class MainViweController: UIViewController {
    private let mainView = MainView(frame: .zero)
    
    private let disposeBag = DisposeBag()
    private var viewModel = MainViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
        
        bind()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: nil,
            action: nil
        )
        didTapAddButton()
    }
    
    private func didTapAddButton() {
        guard let addButton = navigationItem.rightBarButtonItem else {
            return
        }
        
        addButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presentRegistrationView()
            }).disposed(by: disposeBag)
    }
    
    private func presentRegistrationView() {
        let next = UINavigationController(rootViewController: RegistrationViewController())
        
        next.modalPresentationStyle = .formSheet
        
        present(next, animated: true)
    }
    
    private func bind() {
        setUpTable()
        setUpTotalCount()
        setUpGesture()
    }
    
    private func setUpTable() {
        setUpSelection()
        setUpTableCellData()
        deleteProject()
    }
    
    private func setUpSelection() {
        bindItemSelected(to: mainView.toDoTable.tableView)
        bindItemSelected(to: mainView.doingTable.tableView)
        bindItemSelected(to: mainView.doneTable.tableView)
    }
    
    private func bindItemSelected(to tableView: UITableView) {
        tableView.rx
            .itemSelected
            .bind { indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpTableCellData() {
        bind(projects: viewModel.todoProjects, tableView: mainView.toDoTable.tableView)
        bind(projects: viewModel.doingProjects, tableView: mainView.doingTable.tableView)
        bind(projects: viewModel.doneProjects, tableView: mainView.doneTable.tableView)
    }
    
    private func bind(projects: Driver<[ProjectContent]>, tableView: UITableView) {
        projects
            .drive(tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func presentViewController(status: ProjectStatus, cell: ProjectCell) {
        guard let content = viewModel.readProject(cell.contentID) else {
            return
        }
        
        let next = UINavigationController(
            rootViewController: DetailViewController(
                content: content
            )
        )
        
        next.modalPresentationStyle = .formSheet
        
        self.present(next, animated: true)
    }
    
    private func setUpTotalCount() {
        bindCountLabel(of: mainView.toDoTable, to: viewModel.todoProjects)
        bindCountLabel(of: mainView.doingTable, to: viewModel.doingProjects)
        bindCountLabel(of: mainView.doneTable, to: viewModel.doneProjects)
    }
    
    private func bindCountLabel(of tableView: ProjectListView, to projects: Driver<[ProjectContent]>) {
        projects
            .map { "\($0.count)" }
            .drive { count in
                tableView.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpGesture() {
        let toDoTableView = mainView.toDoTable.tableView
        let doingTableView = mainView.doingTable.tableView
        let doneTableView = mainView.doneTable.tableView
        
        bindGesture(to: toDoTableView, status: .todo)
        bindGesture(to: doingTableView, status: .doing)
        bindGesture(to: doneTableView, status: .done)
    }
    
    private func bindGesture(to tableView: UITableView, status: ProjectStatus) {
        tableView.rx
            .anyGesture(
                (.tap(), when: .recognized),
                (.longPress(), when: .began)
            )
            .asObservable()
            .bind { [weak self] event in
                guard let cell = self?.viewModel.findCell(by: event, in: tableView) else {
                    return
                }
                
                if event.state == .began {
                    self?.presentPopOver(cell)
                    return
                }
                self?.presentViewController(status: status, cell: cell)
            }.disposed(by: disposeBag)
    }
    
    private func presentPopOver(_ cell: ProjectCell) {
        let popOverViewController = PopOverViewController(cell: cell)
        
        present(popOverViewController, animated: true, completion: nil)
    }
    
    private func deleteProject() {
        let toDoTableView = mainView.toDoTable.tableView
        let doingTableView = mainView.doingTable.tableView
        let doneTableView = mainView.doneTable.tableView
        
        bindItemDeleted(to: toDoTableView)
        bindItemDeleted(to: doingTableView)
        bindItemDeleted(to: doneTableView)
    }
    
    private func bindItemDeleted(to tableView: UITableView) {
        tableView.delegate = self
        
        tableView.rx
            .itemDeleted
            .asDriver()
            .drive { [weak self] indexPath in
                guard let cell = tableView.cellForRow(at: indexPath) as? ProjectCell else {
                    return
                }
                self?.viewModel.deleteProject(cell.contentID)
            }
            .disposed(by: disposeBag)
    }
}

extension MainViweController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "DELETE") { _, _, completion in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
