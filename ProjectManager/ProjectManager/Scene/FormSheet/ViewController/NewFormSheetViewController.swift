//
//  NewFormSheetViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import RxSwift
import RxCocoa

final class NewFormSheetViewController: UIViewController {
    fileprivate enum Constants {
        static let title: String = "TODO"
        static let done: String = "Done"
        static let cancel: String = "Cancel"
    }
    
    private let newFormSheetView = FormSheetView()
    private let viewModel = NewFormSheetViewModel()
    private let disposeBag = DisposeBag()
    weak var delegate: DataReloadable?
    
    override func loadView() {
        super.loadView()
        view = newFormSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        bind()
    }
    
    private func configureNavigationBarItems() {
        title = Constants.title
        
        let doneButton = UIBarButtonItem(
            title: Constants.done,
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = doneButton
        
        let cancelButton = UIBarButtonItem(
            title: Constants.cancel,
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func bind() {
        newFormSheetView.titleTextField.rx.text.orEmpty
            .bind(to: viewModel.title)
            .disposed(by: disposeBag)
        
        newFormSheetView.bodyTextView.rx.text.orEmpty
            .bind(to: viewModel.body)
            .disposed(by: disposeBag)
        
        newFormSheetView.datePicker.rx.date
            .map { $0.timeIntervalSince1970 }
            .bind(to: viewModel.date)
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.doneButtonTapped()
            }
            .disposed(by: disposeBag)
        
        viewModel.dismiss.asObservable()
            .bind(onNext: backToMain)
            .disposed(by: disposeBag)
        
        viewModel.error.asObservable()
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(message: error.errorDescription)
            })
        .disposed(by: disposeBag)
    }
    
    private func backToMain() {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.reloadData()
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
