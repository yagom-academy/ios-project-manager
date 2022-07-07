//
//  RegistrationViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit
import RxSwift
import RxCocoa

final class RegistrationViewController: UIViewController {
    private let registrationView = ModalView(frame: .zero)
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = "TODO"
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
        guard let title = registrationView.titleTextField.text,
              let description = registrationView.descriptionTextView.text else {
                  return
              }
        let date = registrationView.datePicker.date
        
        var array = viewModel.toDoTableProjects.value
        
        array.append(ProjectContent(ProjectItem(
            title: title,
            deadline: date,
            description: description))
        )
        
        viewModel.toDoTableProjects.accept(array)
    }
}
