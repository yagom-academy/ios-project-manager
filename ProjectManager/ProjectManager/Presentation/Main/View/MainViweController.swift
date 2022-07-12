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
        setUpPopOverView()
    }
    
    private func setUpTable() {
        setUpSelection()
        setUpTableCellData()
        setUpdModelSelected()
        deleteProject()
    }
    
    private func setUpSelection() {
        mainView.toDoTable.tableView.rx
            .itemSelected
            .bind { [weak self] indexPath in
                self?.mainView.toDoTable.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
        
        mainView.doingTable.tableView.rx
            .itemSelected
            .bind { [weak self] indexPath in
                self?.mainView.doingTable.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
        
        mainView.doneTable.tableView.rx
            .itemSelected
            .bind { [weak self] indexPath in
                self?.mainView.doneTable.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpTableCellData() {
        viewModel.todoProjects
            .drive(mainView.toDoTable.tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.doingProjects
            .drive(mainView.doingTable.tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.doneProjects
            .drive(mainView.doneTable.tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpdModelSelected() {
        mainView.toDoTable.tableView.rx
            .modelSelected(ProjectContent.self)
            .asDriver()
            .drive { [weak self] element in
                self?.presentViewController(title: "TODO", content: element)
            }
            .disposed(by: disposeBag)
        
        mainView.doingTable.tableView.rx
            .modelSelected(ProjectContent.self)
            .asDriver()
            .drive { [weak self] element in
                self?.presentViewController(title: "DOING", content: element)
            }
            .disposed(by: disposeBag)
        
        mainView.doneTable.tableView.rx
            .modelSelected(ProjectContent.self)
            .asDriver()
            .drive { [weak self] element in
                self?.presentViewController(title: "DONE", content: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func presentViewController(title: String, content: ProjectContent) {
        let next = UINavigationController(
            rootViewController: DetailViewController(
                title: title,
                content: content,
                mainViewModel: viewModel
            )
        )
        
        next.modalPresentationStyle = .formSheet
        
        self.present(next, animated: true)
    }
    
    private func setUpTotalCount() {
        viewModel.todoProjects
            .map { "\($0.count)" }
            .drive { [weak self] count in
                self?.mainView.toDoTable.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
        
        viewModel.doingProjects
            .map { "\($0.count)" }
            .drive { [weak self] count in
                self?.mainView.doingTable.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
        
        viewModel.doneProjects
            .map { "\($0.count)" }
            .drive { [weak self] count in
                self?.mainView.doneTable.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpPopOverView() {
        let toDoTableView = mainView.toDoTable.tableView
        let doingTableView = mainView.doingTable.tableView
        let doneTableView = mainView.doneTable.tableView
        
        toDoTableView.rx
            .longPressGesture()
            .when(.began)
            .bind { event in
                let point = event.location(in: toDoTableView)
                guard let indexPath = toDoTableView.indexPathForRow(at: point),
                      let cell = toDoTableView.cellForRow(at: indexPath) as? ProjectCell
                else {
                    return
                }
                
                let popOverViewController = PopOverViewController(cell: cell)
                self.present(popOverViewController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        doingTableView.rx
            .longPressGesture()
            .when(.began)
            .bind { event in
                let point = event.location(in: doingTableView)
                guard let indexPath = doingTableView.indexPathForRow(at: point),
                      let cell = doingTableView.cellForRow(at: indexPath) as? ProjectCell
                else {
                    return
                }
                
                let popOverViewController = PopOverViewController(cell: cell)
                self.present(popOverViewController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        doneTableView.rx
            .longPressGesture()
            .when(.began)
            .bind { event in
                let point = event.location(in: doneTableView)
                guard let indexPath = doneTableView.indexPathForRow(at: point),
                      let cell = doneTableView.cellForRow(at: indexPath) as? ProjectCell
                else {
                    return
                }
                
                let popOverViewController = PopOverViewController(cell: cell)
                self.present(popOverViewController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func deleteProject() {
        let toDoTableView = mainView.toDoTable.tableView
        let doingTableView = mainView.doingTable.tableView
        let doneTableView = mainView.doneTable.tableView
        
        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        
        toDoTableView.rx
            .itemDeleted
            .asDriver()
            .drive { [weak self] indexPath in
                guard let cell = toDoTableView.cellForRow(at: indexPath) as? ProjectCell else {
                    return
                }
                self?.viewModel.deleteProject(cell.contentID)
            }
            .disposed(by: disposeBag)
        
        doingTableView.rx
            .itemDeleted
            .asDriver()
            .drive { [weak self] indexPath in
                guard let cell = doingTableView.cellForRow(at: indexPath) as? ProjectCell else {
                    return
                }
                self?.viewModel.deleteProject(cell.contentID)
            }
            .disposed(by: disposeBag)
        
        doneTableView.rx
            .itemDeleted
            .asDriver()
            .drive { [weak self] indexPath in
                guard let cell = doneTableView.cellForRow(at: indexPath) as? ProjectCell else {
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
