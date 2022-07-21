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
    private let viewModel = MainViewModel()
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
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: nil,
            action: nil
        )
        
        let networkConditionImage = UIImage(systemName: "wifi")?.withTintColor(
            .systemBlue,
            renderingMode: .alwaysOriginal
        )
        
        let networkConditionItem = UIBarButtonItem(
            image: networkConditionImage,
            style: .plain,
            target: nil,
            action: nil
        )
        networkConditionItem.isEnabled = false
        
        let loadButton = UIBarButtonItem(
            image: UIImage(systemName: "icloud.and.arrow.down"),
            style: .done,
            target: nil,
            action: nil
        )
        
        navigationItem.rightBarButtonItems = [addButton, loadButton, networkConditionItem]
        didTapAddButton()
    }
    
    private func didTapAddButton() {
        guard let addButton = navigationItem.rightBarButtonItem else {
            return
        }
        
        guard let loadButton = navigationItem.rightBarButtonItems?[1] else {
            return
        }
        
        addButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presentRegistrationView()
            })
            .disposed(by: disposeBag)
        
        loadButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.loadNetworkData()
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
        bindCell(to: viewModel.asTodoProjects(), at: mainView.toDoTable.tableView)
        bindCell(to: viewModel.asDoingProjects(), at: mainView.doingTable.tableView)
        bindCell(to: viewModel.asDoneProjects(), at: mainView.doneTable.tableView)
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
        bindCountLabel(of: mainView.toDoTable, to: viewModel.asTodoProjects())
        bindCountLabel(of: mainView.doingTable, to: viewModel.asDoingProjects())
        bindCountLabel(of: mainView.doneTable, to: viewModel.asDoneProjects())
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
        let gesture = tableView.rx
            .anyGesture(
                (.tap(), when: .recognized),
                (.longPress(), when: .began)
            )
            .asObservable()
        
        gesture.filter { $0.state == .recognized }
            .bind { [weak self] in
                guard let cell = self?.findCell(by: $0, in: tableView) else {
                    return
                }
                self?.presentViewController(status: status, cell: cell)
            }
            .disposed(by: disposeBag)
        
        gesture.filter { $0.state == .began }
            .compactMap { [weak self] in
                self?.findCell(by: $0, in: tableView)
            }
            .bind { [weak self] in
                self?.presentPopOver($0)
            }
            .disposed(by: disposeBag)
    }
    
    private func findCell(by event: RxGestureRecognizer, in tableView: UITableView) -> ProjectCell? {
        let point = event.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: point),
              let cell = tableView.cellForRow(at: indexPath) as? ProjectCell else {
            return nil
        }
        
        return cell
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
