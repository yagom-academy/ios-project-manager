//
//  MainViweController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViweController: UIViewController {
    private let mainView = MainView(frame: .zero)

    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    
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
            target: self,
            action: #selector(presentRegistrationView)
        )
    }
    
    @objc func presentRegistrationView() {
        let next = UINavigationController(rootViewController: RegistrationViewController(viewModel: viewModel))
        
        next.modalPresentationStyle = .formSheet
        
        present(next, animated: true)
    }
    
    private func bind() {
        setUpAddButton()
        setUpTable()
        setUpTotalCount()
    }
    
    private func setUpAddButton() {
        guard let addButton = navigationItem.rightBarButtonItem else {
            return
        }
        
        addButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presentRegistrationView()
            }).disposed(by: disposeBag)
    }
    
    private func setUpTable() {
        setUpSelection()
        setUpTableCellData()
        setUpdModelSelected()
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
        viewModel.toDoTableProjects
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.toDoTable.tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.doingTableProjects
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.doingTable.tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.doneTableProjects
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.doneTable.tableView.rx.items(
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
            .bind(onNext: { [weak self] element in
                let content = Observable.just(element)
                
                let next = UINavigationController(rootViewController: DetailViewController(title: "TODO", content: content, viewModel: self!.viewModel))
                
                next.modalPresentationStyle = .formSheet
                
                self?.present(next, animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.doingTable.tableView.rx
            .modelSelected(ProjectContent.self)
            .bind(onNext: { [weak self] element in
                let content = Observable.just(element)
                
                let next = UINavigationController(rootViewController: DetailViewController(title: "DOING", content: content, viewModel: self!.viewModel))
                
                next.modalPresentationStyle = .formSheet
                
                self?.present(next, animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.doneTable.tableView.rx
            .modelSelected(ProjectContent.self)
            .bind(onNext: { [weak self] element in
                let content = Observable.just(element)
                
                let next = UINavigationController(rootViewController: DetailViewController(title: "DONE", content: content, viewModel: self!.viewModel))
                
                next.modalPresentationStyle = .formSheet
                
                self?.present(next, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpTotalCount() {
        viewModel.toDoTableProjects
            .asDriver()
            .map { "\($0.count)" }
            .drive { [weak self] count in
                self?.mainView.toDoTable.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
        
        viewModel.doingTableProjects
            .asDriver()
            .map { "\($0.count)" }
            .drive { [weak self] count in
                self?.mainView.doingTable.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
        
        viewModel.doneTableProjects
            .asDriver()
            .map { "\($0.count)" }
            .drive { [weak self] count in
                self?.mainView.doneTable.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
    }
}
