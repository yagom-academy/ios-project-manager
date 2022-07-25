//
//  RegistrationViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import RxSwift
import RxCocoa

final class RegistrationViewController: UIViewController {
    private let modalView = ModalView(frame: .zero)
    private let viewModel = RegistrationViewModel()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
        registerNotification()
    }
    
    private func setUpNavigationItem() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = ProjectStatus.todo.string
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: nil
        )
        
        didTapCancelButton()
        didTapSaveButton()
    }
    
    private func didTapCancelButton() {
        guard let cancelButton = navigationItem.leftBarButtonItem else {
            return
        }
        
        cancelButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapSaveButton() {
        guard let saveButton = navigationItem.rightBarButtonItem else {
            return
        }
        
        saveButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.saveProjectContent()
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func saveProjectContent() {
        guard let title = modalView.titleTextField.text,
              let body = modalView.bodyTextView.text else {
                  return
              }
        let date = modalView.datePicker.date
        
        viewModel.registrate(title: title, date: date, body: body)
    }
}

extension RegistrationViewController {
    private func registerNotification() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              modalView.bodyTextView.isFirstResponder == true
        else {
            return
        }
        
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
        
        if let keyboardSize = (keyboardInfo as? NSValue)?.cgRectValue {
            modalView.adjustConstraint(by: keyboardSize.height)
        }
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        modalView.adjustConstraint(by: .zero)
    }
}
