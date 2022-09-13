//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift

class ProjectManagerViewController: UIViewController {
    private let projectManagerView = ProjectManagerView()
    private let viewModel = WorkViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = projectManagerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Manager"
        configureAddBarButton()
        setupBinding()
    }
    
    private func configureAddBarButton() {
        let addWorkBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                               style: .plain, target: self,
                                               action: #selector(addWorkBarButtonTapped))
        self.navigationItem.rightBarButtonItem = addWorkBarButton
    }
    
    @objc private func addWorkBarButtonTapped() {
        let manageViewController = UINavigationController(rootViewController: ManageWorkViewController())
        self.present(manageViewController, animated: true)
    }
    
    // MARK: - UI Binding
        private func setupBinding() {
        bindWorkTableView()
        bindHeaderImage()
        setWorkSelection()        
    }
    
    private func bindWorkTableView() {
        viewModel.todoWorks
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.toDoTableVeiw.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                                                 cellType: WorkTableViewCell.self)) { _, item, cell in
                cell.works.onNext(item)
            }
            .disposed(by: disposeBag)
        
        viewModel.doingWorks
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.doingTableVeiw.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                                                cellType: WorkTableViewCell.self)) { _, item, cell in
               cell.works.onNext(item)
           }
           .disposed(by: disposeBag)
        
        viewModel.doneWorks
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.doneTableVeiw.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                                                cellType: WorkTableViewCell.self)) { _, item, cell in
               cell.works.onNext(item)
           }
           .disposed(by: disposeBag)
    }
    
    private func bindHeaderImage() {
        viewModel.todoCountImage
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.toDoTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.doingCountImage
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.doingTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.doneCountImage
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.doneTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    private func setWorkSelection() {
        projectManagerView.toDoTableVeiw.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                self.showManageWorkView(self, work: self.viewModel.todoWorks.value[index.row])
            }).disposed(by: disposeBag)
        
        projectManagerView.doingTableVeiw.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                self.showManageWorkView(self, work: self.viewModel.doingWorks.value[index.row])
            }).disposed(by: disposeBag)
        
        projectManagerView.doneTableVeiw.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                self.showManageWorkView(self, work: self.viewModel.doneWorks.value[index.row])
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    private func showManageWorkView(_ view: UIViewController, work: Work) {
        let manageViewController = ManageWorkViewController()
        manageViewController.configureWork(work)
        let manageNavigationController = UINavigationController(rootViewController: manageViewController)
        view.present(manageNavigationController, animated: true)
    }
}
