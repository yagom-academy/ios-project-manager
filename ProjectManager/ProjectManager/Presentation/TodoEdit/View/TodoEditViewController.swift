//
//  TodoEditViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol TodoEditViewControllerDependencies: AnyObject {
    func dismissEditViewController()
}

final class TodoEditViewController: UIViewController {
    private enum Constant {
        static let edit = "Edit"
        static let eidting = "Editing"
        static let create = "Create"
        static let cancel = "Cancel"
        static let done = "Done"
        static let navigationBarTitle = "Todo"
    }
    
    private let mainView = TodoEditView()
    private let viewModel: TodoEditViewModel
    private weak var coordinator: TodoEditViewControllerDependencies?
    private let bag = DisposeBag()
    
    private let navigationBar = UINavigationBar()
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private let createButton = UIBarButtonItem()
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    private let editButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRightBarButtonItem()
        configureView()
        bind()
    }
    
    init(viewModel: TodoEditViewModel, coordinator: TodoEditViewControllerDependencies) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension TodoEditViewController {
    private func configureView() {
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureRightBarButtonItem() {
        title = Constant.navigationBarTitle
        editButton.title = Constant.edit
        doneButton.title = Constant.done
        createButton.title = Constant.create
        cancelButton.title = Constant.cancel
        navigationBar.items = [navigationItem]
    }
    
    private func configureLeftBarButtonItem(isCreateMode: Bool) {
        if isCreateMode {
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = createButton
        } else {
            navigationItem.leftBarButtonItem = editButton
            navigationItem.rightBarButtonItem = doneButton
        }
    }
}

//MARK: - ViewModel Bind
extension TodoEditViewController {
    private func bind() {
        viewModel.setUpView
            .bind { [weak self] in
                self?.mainView.setupView(by: $0)
            }.disposed(by: bag)
        
        viewModel.setCreateMode
            .bind { [weak self] in
                self?.mainView.changeEnabled($0)
                self?.configureLeftBarButtonItem(isCreateMode: $0)
            }.disposed(by: bag)
        
        viewModel.setEditMode
            .bind { [weak self] in
                self?.mainView.changeEnabled($0)
                self?.editButton.title = $0 ? Constant.eidting : Constant.edit
            }.disposed(by: bag)
        
        cancelButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.coordinator?.dismissEditViewController()
            }.disposed(by: bag)
        
        doneButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.dismissEditViewController()
                self?.viewModel.doneButtonDidTap()
            }.disposed(by: bag)
        
        createButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.dismissEditViewController()
                self?.viewModel.createButtonDidTap()
            }.disposed(by: bag)
        
        editButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.editButtonDidTap()
            }.disposed(by: bag)
        
        mainView.rx.titleText
            .bind { [weak self] in
                self?.viewModel.inputitle(title: $0)
            }.disposed(by: bag)
        
        mainView.rx.datePicker
            .bind { [weak self] in
                self?.viewModel.inputDeadline(deadline: $0)
            }.disposed(by: bag)
        
        mainView.rx.bodyText
            .bind { [weak self] in
                self?.viewModel.inputBody(body: $0)
            }.disposed(by: bag)
    }
}
