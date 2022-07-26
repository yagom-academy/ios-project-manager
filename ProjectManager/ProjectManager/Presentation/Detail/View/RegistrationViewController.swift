//
//  RegistrationViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import RxSwift
import RxCocoa

private enum Constant {
    static let done = "done"
    static let cancel = "cancel"
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttribute()
        setUpLayout()
        setUpNavigationItem()
        modalView.registerNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setUpAttribute() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private func setUpLayout() {
        view.addSubview(modalView)
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modalView.widthAnchor.constraint(equalToConstant: 500),
            modalView.heightAnchor.constraint(equalToConstant: 600),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setUpNavigationItem() {
        modalView.navigationBar.modalTitle.text = ProjectStatus.todo.string
        modalView.navigationBar.leftButton.setTitle(Constant.cancel, for: .normal)
        modalView.navigationBar.rightButton.setTitle(Constant.done, for: .normal)
        
        didTapCancelButton()
        didTapSaveButton()
    }
    
    private func didTapCancelButton() {
        let cancelButton = modalView.navigationBar.leftButton
        
        cancelButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapSaveButton() {
        let saveButton = modalView.navigationBar.rightButton
        
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
