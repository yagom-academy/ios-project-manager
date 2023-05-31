//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let viewModel: WorkViewModel
    private let todoCollectionView: WorkCollectionView
    private let doingCollectionView: WorkCollectionView
    private let doneCollectionView: WorkCollectionView
    
    init() {
        self.viewModel = WorkViewModel()
        self.todoCollectionView = WorkCollectionView(status: WorkViewModel.WorkStatus.todo, viewModel: viewModel)
        self.doingCollectionView = WorkCollectionView(status: WorkViewModel.WorkStatus.doing, viewModel: viewModel)
        self.doneCollectionView = WorkCollectionView(status: WorkViewModel.WorkStatus.done, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
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
            name: .requestingAlert,
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
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        configureDelegate()
    }
    
    private func createWorksCollectionStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [todoCollectionView,
                                                       doingCollectionView,
                                                       doneCollectionView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }
}

extension MainViewController: WorkCollectionViewDelegate {
    private func configureDelegate() {
        todoCollectionView.delegate = todoCollectionView
        doingCollectionView.delegate = doingCollectionView
        doneCollectionView.delegate = doneCollectionView
        
        todoCollectionView.workDelegate = self
        doingCollectionView.workDelegate = self
        doneCollectionView.workDelegate = self
    }
    
    func workCollectionView(_ collectionView: WorkCollectionView, id: UUID) {
        let detailViewController = DetailViewController(viewModel: viewModel, viewMode: .edit, id: id)
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
    
    func workCollectionView(_ collectionView: WorkCollectionView, moveWork id: UUID, toStatus status: WorkViewModel.WorkStatus, rect: CGRect) {
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
