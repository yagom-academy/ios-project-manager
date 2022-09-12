//
//  CardEnrollmentViewController.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

final class CardEnrollmentViewController: UIViewController {
    private enum Const {
        static let title = "TODO"
        static let cancel = "Cancel"
        static let done = "Done"
        static let stackViewSpacing = 10.0
        static let limitedTextAmount = 1000
    }
    
    private var viewModel: CardViewModelProtocol?
    private let cardModalView = CardModalView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: CardViewModelProtocol) {
        self.viewModel = viewModel
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
        self.cardModalView.descriptionTextView.delegate = self
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
        cardModalView.leftBarButtonItem = UIBarButtonItem(title: Const.cancel,
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(cancelButtonDidTapped))

        cardModalView.rightBarButtonItem = UIBarButtonItem(title: Const.done,
                                                          style: .done,
                                                          target: self,
                                                          action: #selector(doneButtonDidTapped))
        
        navigationItem.leftBarButtonItem = cardModalView.leftBarButtonItem
        navigationItem.rightBarButtonItem = cardModalView.rightBarButtonItem
        
        cardModalView.navigationBar.items = [navigationItem]
    }
    
    @objc func cancelButtonDidTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonDidTapped() {
        self.dismiss(animated: true)
    }
}

// MARK: - UITextViewDelegate

extension CardEnrollmentViewController: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        guard textView.text.count < Const.limitedTextAmount else {
            return false
        }
        
        return true
    }
}
