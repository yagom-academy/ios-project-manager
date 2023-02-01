//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/18.
//

import UIKit

final class PopoverViewController: UIViewController {
    private let id: UUID
    private let state: State
    private let notification = Notification.Name("DismissForReload")
    
    private let topButton = UIButton(title: "Move To DOING", titleColor: .systemBlue)
    private let bottomButton = UIButton(title: "Move To DONE", titleColor: .systemBlue)
    private let stackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, distribution: .fillEqually)
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        
        return stackView
    }()
    
    init(id: UUID, state: State) {
        self.id = id
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        configureLayout()
        setButtonTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.preferredContentSize = self.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        self.view.addSubview(stackView)
        [topButton, bottomButton].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func setButtonTitle() {
        switch state {
        case .todo:
            topButton.setTitle("Move To DOING", for: .normal)
            bottomButton.setTitle("Move To DONE", for: .normal)
            topButton.addTarget(self, action: #selector(tapDoingButton), for: .touchUpInside)
            bottomButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
        case .doing:
            topButton.setTitle("Move To TODO", for: .normal)
            bottomButton.setTitle("Move To DONE", for: .normal)
            topButton.addTarget(self, action: #selector(tapTodoButton), for: .touchUpInside)
            bottomButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
        case .done:
            topButton.setTitle("Move To TODO", for: .normal)
            bottomButton.setTitle("Move To DOING", for: .normal)
            topButton.addTarget(self, action: #selector(tapTodoButton), for: .touchUpInside)
            bottomButton.addTarget(self, action: #selector(tapDoingButton), for: .touchUpInside)
        }
    }
    
    @objc private func tapTodoButton() {
        CoreDataManager.shared.updateData(id: id, state: .todo)
        NotificationCenter.default.post(name: notification, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
    
    @objc private func tapDoingButton() {
        CoreDataManager.shared.updateData(id: id, state: .doing)
        NotificationCenter.default.post(name: notification, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
    
    @objc private func tapDoneButton() {
        CoreDataManager.shared.updateData(id: id, state: .done)
        NotificationCenter.default.post(name: notification, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
    
    func configureView(
        _ sourceRect: CGRect,
        _ sourceView: UIView,
        _ arrowDirections: UIPopoverArrowDirection = [.up, .down]
    ) {
        self.popoverPresentationController?.sourceRect = sourceRect
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.permittedArrowDirections = arrowDirections
    }
}
