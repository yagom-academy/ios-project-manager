//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import UIKit

final class MainViewController: UIViewController {
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let mainViewModel: MainViewModel
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren()
        configureNavigationBar()
        configureRootView()
        configureStackView()
        fetchInitialTaskList()
    }

    private func configureNavigationBar() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(presentDetailView)
        )
    }
    
    @objc
    private func presentDetailView() {
        let detailViewModelDelegate = mainViewModel.todoViewModel() as? DetailViewModelDelegate
        let detailViewModel = DetailViewModel(mode: .create)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        detailViewController.configureViewModelDelegate(with: detailViewModelDelegate)
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        self.present(navigationController, animated: true)
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(stackView)
    }
    
    private func addChildren() {
        let todoViewModel = TodoViewModel()
        let doingViewModel = DoingViewModel()
        let doneViewModel = DoneViewModel()
        
        self.addChild(TaskCollectionViewController<TodoViewModel.TodoSection>(viewModel: todoViewModel))
        self.addChild(TaskCollectionViewController<DoingViewModel.DoingSection>(viewModel: doingViewModel))
        self.addChild(TaskCollectionViewController<DoneViewModel.DoneSection>(viewModel: doneViewModel))
        
        mainViewModel.assignChildViewModel(of: [
            todoViewModel,
            doingViewModel,
            doneViewModel
        ])
    }
    
    private func configureStackView() {
        self.children.forEach {
            stackView.addArrangedSubview($0.view)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func fetchInitialTaskList() {
        mainViewModel.fetchTaskList()
        mainViewModel.distributeTask()
    }
}
