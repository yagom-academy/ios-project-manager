//
//  ManageWorkViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit
import RxRelay
import RxSwift

final class ManageWorkViewController: UIViewController {
    private enum ViewMode {
        case add
        case edit
    }
    
    private let disposeBag = DisposeBag()
    private let workManageView = WorkManageView()
    private var viewMode: ViewMode = .edit
    private var viewModel: WorkViewModel?
    private var work: Work?
    
    override func loadView() {
        super.loadView()
        self.view = workManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let cancleBarButton = UIBarButtonItem(title: "Cancle",
                                              style: .plain,
                                              target: self,
                                              action: #selector(cancelBarButtonTapped))
        let doneBarButton = UIBarButtonItem(title: "Done",
                                            style: .done,
                                            target: self,
                                            action: #selector(doneBarButtonTapped))
        let editBarButton = UIBarButtonItem(title: "Edit",
                                            style: .done,
                                            target: self,
                                            action: #selector(editBarButtonTapped))
        switch viewMode {
        case .add:
            self.navigationItem.leftBarButtonItem = cancleBarButton
            self.navigationItem.title = "TODO"
        case .edit:
            self.navigationItem.leftBarButtonItem = editBarButton
            self.navigationItem.title = work?.state.rawValue
        }
        
        self.navigationItem.rightBarButtonItem = doneBarButton
    }

    @objc private func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func editBarButtonTapped() {
        workManageView.changeEditMode(true)
    }
    
    @objc private func doneBarButtonTapped() {
        guard let viewModel = viewModel else { return }
        
        switch viewMode {
        case .add:
            guard let newWork = workManageView.createNewWork() else { return }
            
            viewModel.todoWorks.accept([newWork] + viewModel.todoWorks.value)
        case .edit:
            editWork(viewModel)
        }
        
        self.dismiss(animated: true)
    }
    
    private func editWork(_ viewModel: WorkViewModel) {
        let works: BehaviorRelay<[Work]>
        guard let work = work,
              let newWork = self.workManageView.createNewWork(id: work.id, state: work.state) else { return }
        
        switch work.state {
        case .todo:
            works = viewModel.todoWorks
        case .doing:
            works = viewModel.doingWorks
        case .done:
            works = viewModel.doneWorks
        }
        
        works.map {
            $0.map {
                return $0.id == work.id ? newWork : $0
            }
        }.observe(on: MainScheduler.asyncInstance)
            .take(1)
            .bind(to: works)
            .disposed(by: disposeBag)
    }
    
    func configureAddMode(_ viewModel: WorkViewModel) {
        self.viewModel = viewModel
        viewMode = .add
    }
    
    func configureEditMode(with work: Work, _ viewModel: WorkViewModel) {
        workManageView.configure(with: work)
        workManageView.changeEditMode(false)
        self.viewModel = viewModel
        self.work = work
    }
}
