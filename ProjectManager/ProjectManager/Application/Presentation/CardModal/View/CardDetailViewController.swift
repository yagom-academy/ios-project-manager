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
    
    private let viewModel: CardViewModelProtocol
    private let model: CardModel
    private var isClickedEdition = false
    
    private let cardModalView = CardModalView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: CardViewModelProtocol,
         model: CardModel) {
        self.viewModel = viewModel
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        configureLayout()
        configureNavigationItem()
    }
    
    private func setupDefault() {
        self.view.addSubview(cardModalView)
        cardModalView.descriptionTextView.delegate = self

        cardModalView.titleTextField.isUserInteractionEnabled = false
        cardModalView.descriptionTextView.isEditable = false
        cardModalView.datePicker.isUserInteractionEnabled = false

        bindUI()
    }

    private func bindUI() {
        cardModalView.titleTextField.text = model.title
        cardModalView.descriptionTextView.text = model.description
        cardModalView.datePicker.date = model.deadlineDate
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
                                                          action: #selector(didTapEditButton))
        
        cardModalView.rightBarButtonItem = UIBarButtonItem(title: Const.done,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapDoneButton))
        
        navigationItem.leftBarButtonItem = cardModalView.leftBarButtonItem
        navigationItem.rightBarButtonItem = cardModalView.rightBarButtonItem
        
        cardModalView.navigationBar.items = [navigationItem]
    }
    
    private func toggleEditingMode() {
        isClickedEdition.toggle()
        cardModalView.titleTextField.isUserInteractionEnabled.toggle()
        cardModalView.descriptionTextView.isEditable.toggle()
        cardModalView.datePicker.isUserInteractionEnabled.toggle()
        
        let title = isClickedEdition ? Const.editing : Const.edit
        cardModalView.leftBarButtonItem.title = title
    }

    private func updateData() {
        guard let title = cardModalView.titleTextField.text,
              let description = cardModalView.descriptionTextView.text else { return }
        let deadlineDate = cardModalView.datePicker.date
        let data = CardModel(id: model.id,
                             title: title,
                             description: description,
                             deadlineDate: deadlineDate,
                             cardType: model.cardType)

        self.viewModel.update(data)
    }
    
    @objc func didTapEditButton() {
        toggleEditingMode()
    }
    
    @objc func didTapDoneButton() {
        updateData()
        self.dismiss(animated: true)
    }
}

// MARK: - UITextViewDelegate

extension CardDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        guard textView.text.count < Const.limitedTextAmount else {
            return false
        }
        
        return true
    }
}
