//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let viewModel = WorkViewModel()
    private let todoCollectionView: WorkCollectionView
    private let doingCollectionView: WorkCollectionView
    private let doneCollectionView: WorkCollectionView
    
    init() {
        self.todoCollectionView = WorkCollectionView(status: WorkStatus.todo, viewModel: viewModel)
        self.doingCollectionView = WorkCollectionView(status: WorkStatus.doing, viewModel: viewModel)
        self.doneCollectionView = WorkCollectionView(status: WorkStatus.done, viewModel: viewModel)
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
        let detailViewController = DetailViewController()
        detailViewController.configureAddMode()
        detailViewController.viewModel = viewModel
        
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
            self?.viewModel.currentID = id
            self?.viewModel.removeWork()
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
        stackView.spacing = 8
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }
}

extension MainViewController: UICollectionViewDelegate, WorkCollectionViewDelegate {
    private func configureDelegate() {
        todoCollectionView.delegate = todoCollectionView
        doingCollectionView.delegate = doingCollectionView
        doneCollectionView.delegate = doneCollectionView
        
        todoCollectionView.workDelegate = self
        doingCollectionView.workDelegate = self
        doneCollectionView.workDelegate = self
    }
    
    func workCollectionView(_ collectionView: WorkCollectionView, id: UUID) {
        viewModel.currentID = id
        
        let detailViewController = DetailViewController()
        detailViewController.viewModel = viewModel
        detailViewController.configureEditMode()
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        
        present(navigationController, animated: true)
    }
    
    func workCollectionView(_ collectionView: WorkCollectionView, moveWork id: UUID, toStatus status: WorkStatus, rect: CGRect) {
        viewModel.currentID = id
        showPopoverViewController(status: status, rect: rect)
    }
    
    private func showPopoverViewController(status: WorkStatus, rect: CGRect) {
        let popoverViewController = PopoverViewController(status: status, viewModel: viewModel)
        
        popoverViewController.modalPresentationStyle = .popover
        popoverViewController.popoverPresentationController?.sourceView = view
        popoverViewController.popoverPresentationController?.sourceRect = rect
        
        present(popoverViewController, animated: true)
    }
}
