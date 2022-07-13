//
//  RegistrationViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import RxSwift
import RxCocoa
import RxKeyboard

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
        modalView.descriptionTextView.delegate = self
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
              let description = modalView.descriptionTextView.text else {
                  return
              }
        let date = modalView.datePicker.date
        
        viewModel.registrate(title: title, date: date, description: description)
    }
}

extension RegistrationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 170
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
