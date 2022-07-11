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

class TodoEditViewController: UIViewController {
    private let mainView = TodoEditView()
    private let viewModel: TodoEditViewModel
    private let bag = DisposeBag()
    
    private let navigationBar = UINavigationBar()
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
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
    
    private func configureNavigationBar() {
        title = "Todo"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
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
                self.viewModel.doneButtonDidTap(item: self.mainView.readViewContent())
            }.disposed(by: bag)
    }
}
