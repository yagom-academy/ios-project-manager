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

final class TodoEditViewController: UIViewController {
    private enum Constant {
        static let edit = "Edit"
        static let eidting = "Editing"
        static let navigationBarTitle = "Todo"
    }
    
    private let mainView = TodoEditView()
    private let viewModel: TodoEditViewModel
    private let bag = DisposeBag()
    
    private let navigationBar = UINavigationBar()
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    private let editButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRightBarButtonItem()
        configureView()
        bind()
    }
    
    init(viewModel: TodoEditViewModel) {
        self.viewModel = viewModel
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
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
    }
    

    private func configureRightBarButtonItem() {
        title = Constant.navigationBarTitle
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
    }
    
    private func configureLeftBarButtonItem(isCreateMode: Bool) {
        if isCreateMode {
            navigationItem.leftBarButtonItem = cancelButton
        } else {
            navigationItem.leftBarButtonItem = editButton
            editButton.title = Constant.edit
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
        
        cancelButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.viewModel.cancelButtonDidTap()
            }.disposed(by: bag)
        
        doneButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.viewModel.doneButtonDidTap()
            }.disposed(by: bag)
        
        editButton.rx.tap
            .withUnretained(self)
            .map { (self, _) in
                self.viewModel.editButtonDidTap()
            }.bind { [weak self] in
                self?.mainView.changeEnabled($0)
                self?.editButton.title = $0 ? Constant.eidting : Constant.edit
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
