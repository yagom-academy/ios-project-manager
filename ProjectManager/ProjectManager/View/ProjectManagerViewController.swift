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
        setupBinding()
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
        
    }
}
