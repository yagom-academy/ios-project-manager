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
        modalPresentationStyle = .popover
        self.present(manageViewController, animated: true)

    }
    
    // MARK: - UI Binding
    
    private func setupBinding() {
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
        
        viewModel.todoWorks
            .map {
                UIImage(systemName: "\($0.count).circle.fill")
            }
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.toDoTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.doingWorks
            .map {
                UIImage(systemName: "\($0.count).circle.fill")
            }
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.doingTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.doneWorks
            .map {
                UIImage(systemName: "\($0.count).circle.fill")
            }
            .observe(on: MainScheduler.instance)
            .bind(to: projectManagerView.doneTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        projectManagerView.toDoTableVeiw.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                let manageViewController = ManageWorkViewController()
                manageViewController.configureWork((self.viewModel.todoWorks.value[index.row]))
                let manageNavigationController = UINavigationController(rootViewController: manageViewController)
                self.present(manageNavigationController, animated: true)
            }).disposed(by: disposeBag)
        
        projectManagerView.doingTableVeiw.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                let manageViewController = ManageWorkViewController()
                manageViewController.configureWork((self.viewModel.doingWorks.value[index.row]))
                let manageNavigationController = UINavigationController(rootViewController: manageViewController)
                self.present(manageNavigationController, animated: true)
            }).disposed(by: disposeBag)
        
        projectManagerView.doneTableVeiw.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                let manageViewController = ManageWorkViewController()
                manageViewController.configureWork((self.viewModel.doneWorks.value[index.row]))
                let manageNavigationController = UINavigationController(rootViewController: manageViewController)
                self.present(manageNavigationController, animated: true)
            }).disposed(by: disposeBag)
    }
}
