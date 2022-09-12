//
//  CardDetailViewController.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

final class CardDetailViewController: UIViewController {
    private enum Const {
        static let title = "TODO"
        static let edit = "Edit"
        static let editing = "Editing"
        static let done = "Done"
        static let stackViewSpacing = 10.0
        static let limitedTextAmount = 1000
    }
    
    private var viewModel: CardViewModelProtocol?
    private var model: TodoListModel?
    private var isEditable = false
    
    private let cardModalView = CardModalView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: CardViewModelProtocol, model: TodoListModel) {
        self.viewModel = viewModel
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        configureLayout()
        configureNavigationItem()
    }
    
    private func setupDefault() {
        self.view.addSubview(cardModalView)
        
        cardModalView.titleTextField.isUserInteractionEnabled = false
        cardModalView.descriptionTextView.isEditable = false
        cardModalView.datePicker.isUserInteractionEnabled = false
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            cardModalView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cardModalView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            cardModalView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            cardModalView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureNavigationItem() {
        title = Const.title
        cardModalView.leftBarButtonItem = UIBarButtonItem(title: Const.edit,
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(editButtonDidTapped))
        
        cardModalView.rightBarButtonItem = UIBarButtonItem(title: Const.done,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(doneButtonDidTapped))
        
        navigationItem.leftBarButtonItem = cardModalView.leftBarButtonItem
        navigationItem.rightBarButtonItem = cardModalView.rightBarButtonItem
        
        cardModalView.navigationBar.items = [navigationItem]
    }
    
    private func toggleEditingMode() {
        isEditable.toggle()
        cardModalView.titleTextField.isUserInteractionEnabled.toggle()
        cardModalView.descriptionTextView.isEditable.toggle()
        cardModalView.datePicker.isUserInteractionEnabled.toggle()
        
        let title = isEditable ? Const.editing : Const.edit
        cardModalView.leftBarButtonItem.title = title
    }
    
    @objc func editButtonDidTapped() {
        toggleEditingMode()
    }
    
    @objc func doneButtonDidTapped() {
        self.dismiss(animated: true)
    }
}
    }
}
