//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import RxSwift
import RxCocoa
import RxGesture

final class MainViewController: UIViewController {
    private let mainView = MainView(frame: .zero)
    private var viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        setUpNavigationItem()
        setUpTable()
        setUpTotalCount()
        setUpGesture()
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
        
        addButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presentRegistrationView()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentRegistrationView() {
        let next = UINavigationController(rootViewController: RegistrationViewController())
        
        next.modalPresentationStyle = .formSheet
        
        present(next, animated: true)
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
        bindCell(to: viewModel.todoProjects, at: mainView.toDoTable.tableView)
        bindCell(to: viewModel.doingProjects, at: mainView.doingTable.tableView)
        bindCell(to: viewModel.doneProjects, at: mainView.doneTable.tableView)
    }
    
    private func bindCell(to projects: Driver<[ProjectContent]>, at tableView: UITableView) {
        projects
            .drive(tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func deleteProject() {
        bindModelDeleted(at: mainView.toDoTable.tableView)
        bindModelDeleted(at: mainView.doingTable.tableView)
        bindModelDeleted(at: mainView.doneTable.tableView)
    }
    
    private func bindModelDeleted(at tableView: UITableView) {
        tableView.rx
            .modelDeleted(ProjectContent.self)
            .asDriver()
            .drive { [weak self] project in
                self?.viewModel.deleteProject(project)
            }
            .disposed(by: disposeBag)
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
        bindGesture(to: mainView.toDoTable.tableView, status: .todo)
        bindGesture(to: mainView.doingTable.tableView, status: .doing)
        bindGesture(to: mainView.doneTable.tableView, status: .done)
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
            }
            .disposed(by: disposeBag)
    }
    
    private func presentPopOver(_ cell: ProjectCell) {
        let popOverViewController = PopOverViewController(cell: cell)
        
        present(popOverViewController, animated: true)
    }
    
    private func presentViewController(status: ProjectStatus, cell: ProjectCell) {
        guard let content = viewModel.readProject(cell.contentID) else {
            return
        }
        
        let next = UINavigationController(
            rootViewController: DetailViewController(content: content)
        )
        
        next.modalPresentationStyle = .formSheet
        
        self.present(next, animated: true)
    }
}
