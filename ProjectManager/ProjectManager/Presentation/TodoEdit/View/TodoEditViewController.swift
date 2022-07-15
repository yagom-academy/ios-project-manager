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
    
    private let todoItem: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bind()
        configureIsEnabled()
    }
    
    init(viewModel: TodoEditViewModel, item: TodoModel?) {
        self.viewModel = viewModel
        self.todoItem = item
        mainView.setupView(by: todoItem)
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
    
    private func configureNavigationBar() {
        title = Constant.navigationBarTitle
        if todoItem == nil {
            navigationItem.leftBarButtonItem = cancelButton
        } else {
            editButton.title = Constant.edit
            navigationItem.leftBarButtonItem = editButton
        }
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
    }
    
    private func configureIsEnabled() {
        if todoItem != nil {
            mainView.changeEnabled(false)
        }
    }
}

//MARK: - ViewModel Bind
extension TodoEditViewController {
    private func bind() {
        cancelButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.viewModel.cancelButtonDidTap()
            }.disposed(by: bag)
        
        doneButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                let newItem = self.mainView.readViewContent(id: self.todoItem?.id,
                                                            state: self.todoItem?.state)
                self.viewModel.doneButtonDidTap(item: newItem)
            }.disposed(by: bag)
        
        editButton.rx.tap
            .withUnretained(self)
            .map { (self, _) in
                self.editButton.title == Constant.edit
            }.bind { [weak self] in
                self?.mainView.changeEnabled($0)
                self?.editButton.title = $0 ? Constant.eidting : Constant.edit
            }.disposed(by: bag)
    }
}
