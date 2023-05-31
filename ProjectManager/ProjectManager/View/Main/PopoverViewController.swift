//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/24.
//

import UIKit

final class PopoverViewController: UIViewController {
    let status: WorkViewModel.WorkStatus
    let viewModel: WorkViewModel
    let id: UUID
    
    private let topButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        
        return button
    }()
    
    private let buttomButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        
        return button
    }()
    
    init(status: WorkViewModel.WorkStatus, viewModel: WorkViewModel, id: UUID) {
        self.status = status
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIOption()
        configureButtonAction()
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemGray5
        topButton.setTitle(status.movedButtonName.top, for: .normal)
        buttomButton.setTitle(status.movedButtonName.bottom, for: .normal)
        preferredContentSize = calculatePopoverSize()
    }
    
    private func createPopoverButtonStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [topButton, buttomButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }
    
    private func configureLayout() {
        let stackView = createPopoverButtonStackView()
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func calculatePopoverSize() -> CGSize {
        topButton.sizeToFit()
        buttomButton.sizeToFit()
        
        return CGSize(width: 250, height: 100)
    }
    
    private func configureButtonAction() {
        topButton.addTarget(self, action: #selector(didTapTopButton), for: .touchUpInside)
        buttomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
    }
    
    @objc private func didTapTopButton() {
        switch status {
        case .todo:
            viewModel.moveStatus(id: id, to: .doing)
        case .doing:
            viewModel.moveStatus(id: id, to: .todo)
        case .done:
            viewModel.moveStatus(id: id, to: .todo)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapBottomButton() {
        switch status {
        case .todo:
            viewModel.moveStatus(id: id, to: .done)
        case .doing:
            viewModel.moveStatus(id: id, to: .done)
        case .done:
            viewModel.moveStatus(id: id, to: .doing)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
