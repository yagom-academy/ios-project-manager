//
//  EditFormSheetViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/07.
//

import UIKit
import RxSwift
import RxCocoa

final class EditFormSheetViewController: UIViewController {
    fileprivate enum Constants {
        static let done: String = "Done"
        static let edit: String = "Edit"
    }
    
    private let viewModel = EditFormSheetViewModel()
    private let editFormSheetView = FormSheetView()
    private let disposeBag = DisposeBag()
    weak var delegate: DataReloadable?
    var task: Task?
    
    override func loadView() {
        super.loadView()
        view = editFormSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        setupContents()
        bind()
    }
    
    private func configureNavigationBarItems() {
        title = task?.taskType.value
        
        let doneButton = UIBarButtonItem(
            title: Constants.done,
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        let editButton = UIBarButtonItem(
            title: Constants.edit,
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.leftBarButtonItem = editButton
    }
    
    private func setupContents() {
        if let task = task {
            editFormSheetView.setUpContents(task: task)
        }
    }
    
    private func bind() {
        editFormSheetView.titleTextField.rx.text.orEmpty
            .bind(to: viewModel.title)
            .disposed(by: disposeBag)
        
        editFormSheetView.bodyTextView.rx.text.orEmpty
            .bind(to: viewModel.body)
            .disposed(by: disposeBag)
        
        editFormSheetView.datePicker.rx.date
            .map { $0.timeIntervalSince1970 }
            .bind(to: viewModel.date)
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .subscribe { [weak self] _ in
                guard let task = self?.task else { return }
                self?.viewModel.editButtonTapped(task: task)
            }
            .disposed(by: disposeBag)
        
        viewModel.dismiss.asObservable()
            .bind(onNext: backToMain)
            .disposed(by: disposeBag)
    }
    
    private func backToMain() {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.reloadData()
        }
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
}
