//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/18.
//

import UIKit

final class PopoverViewController: UIViewController {
    private let coredataManager = CoreDataManager()
    private let id: UUID
    private let state: State
    
    private let topButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move To DOING", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        
        return button
    }()
    
    private let bottomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move To DONE", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
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
        self.view.addSubview(stackView)
        [topButton, bottomButton].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        coredataManager.updateData(id: id, state: .todo)
        dismiss(animated: true)
    }
    
    @objc private func tapDoingButton() {
        coredataManager.updateData(id: id, state: .doing)
        dismiss(animated: true)
    }
    
    @objc private func tapDoneButton() {
        coredataManager.updateData(id: id, state: .done)
        dismiss(animated: true)
    }
}
