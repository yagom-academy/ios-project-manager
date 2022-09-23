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
    // MARK: - Inner types
    private enum ViewMode {
        case add
        case edit
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let workManageView = WorkManageView()
    private let viewModel: WorkViewModel
    private var viewMode: ViewMode?
    private var work: Work?
    
    override func loadView() {
        super.loadView()
        self.view = workManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - initializer
    init(viewModel: WorkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI setup
    private func configureUI() {
        guard let viewMode = viewMode else { return }

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

    // MARK: - Methods
    @objc private func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func editBarButtonTapped() {
        workManageView.changeEditMode(true)
    }
    
    @objc private func doneBarButtonTapped() {
        guard let viewMode = viewMode else { return }
        
        switch viewMode {
        case .add:
            guard let newWork = workManageView.createNewWork() else { return }

            viewModel.addWork(newWork)
        case .edit:
            guard let work = work,
                  let newWork = self.workManageView.createNewWork(id: work.id, state: work.state) else { return }

            viewModel.editWork(work, newWork: newWork)
        }
        
        self.dismiss(animated: true)
    }
    
    func configureAddMode() {
        self.viewMode = .add
    }
    
    func configureEditMode(with work: Work) {
        workManageView.configure(with: work)
        workManageView.changeEditMode(false)
        self.viewMode = .edit
        self.work = work
    }
}
