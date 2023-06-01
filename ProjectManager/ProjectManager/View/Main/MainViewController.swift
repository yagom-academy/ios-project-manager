//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let viewModel: WorkViewModel
    
    init() {
        self.viewModel = WorkViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
        addchildren()
        configureCollectionListView()
        addAlertObserver()
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(presentAppendWork))
    }
    
    private func addchildren() {
        addChild(WorkCollectionViewController(status: .todo, viewModel: viewModel))
        addChild(WorkCollectionViewController(status: .doing, viewModel: viewModel))
        addChild(WorkCollectionViewController(status: .done, viewModel: viewModel))
    }
    
    @objc private func presentAppendWork() {
        let detailViewController = DetailViewController(viewModel: viewModel, viewMode: .add, id: nil)
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
    
    private func addAlertObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showAlert),
            name: .workDeleted,
            object: nil
        )
    }
    
    @objc private func showAlert(_ noti: Notification) {
        guard let id = noti.object as? UUID else { return }
        
        let handler = { [weak self] in
            guard let self else { return }
            
            self.viewModel.removeWork(id: id)
        }
            
        AlertManager().showAlert(target: self,
                                 title: "할 일 삭제",
                                 message: "정말로 삭제하시겠습니까?",
                                 handler: handler)
    }
}

// MARK: - Collection View Setting
extension MainViewController {
    private func configureCollectionListView() {
        let stackView = createWorksCollectionStackView()
        
        view.addSubview(stackView)
        children.forEach {
            stackView.addArrangedSubview($0.view)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        configureDelegate()
    }
    
    private func createWorksCollectionStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }
}

// MARK: - Work Collection View Controller Delegate
extension MainViewController: WorkCollectionViewControllerDelegate {
    private func configureDelegate() {
        children.forEach {
            guard let viewController = $0 as? WorkCollectionViewController else { return }
            viewController.delegate = self
        }
    }
    
    func workCollectionViewController(id: UUID) {
        let detailViewController = DetailViewController(viewModel: viewModel, viewMode: .edit, id: id)
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
    
    func workCollectionViewController(moveWork id: UUID, toStatus status: WorkViewModel.WorkStatus, rect: CGRect) {
        showPopoverViewController(status: status, rect: rect, id: id)
    }
    
    private func showPopoverViewController(status: WorkViewModel.WorkStatus, rect: CGRect, id: UUID) {
        let popoverViewController = PopoverViewController(status: status, viewModel: viewModel, id: id)
        
        popoverViewController.modalPresentationStyle = .popover
        popoverViewController.popoverPresentationController?.sourceView = view
        popoverViewController.popoverPresentationController?.sourceRect = rect
        
        present(popoverViewController, animated: true)
    }
}
