//
//  TodoAddViewController.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/12.
//

import UIKit
import RxSwift

class TodoAddViewController: UIViewController {
    
    //MARK: - Dependancy Injection
    
    var isNewTask: Bool?
    var state: ProjetTaskState?
    var projectTask: ProjectTask? {
        didSet {
            configure()
        }
    }
    var viewModel: ProjectTaskViewModel?
    
    // MARK: - Properties
    
    private let disposedBag = DisposeBag()
    private lazy var todoAddView = TodoAddView(frame: .zero)
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        projectTask = viewModel?.selectedTask
        setupTodoAddView()
        setupNavigationBarItem()
    }
}

private extension TodoAddViewController {
    
    //MARK: - Root View Setup
    
    func setupTodoAddView() {
        todoAddView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoAddView)
        NSLayoutConstraint.activate([
            todoAddView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoAddView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoAddView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            todoAddView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBarItem() {
        navigationItem.title = state?.rawValue
        view.backgroundColor = .systemGray5
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func doneButtonDidTapped() {
        guard let state = state else {
            return
        }
        
        if let isNewTask {
            guard let extractedTask = extractCurrentTask() else {
                return
            }
            
            viewModel?.createTask(to: extractedTask)
        } else {
            guard let projectTask = projectTask else {
                return
            }
            
            viewModel?.updateTask(at: state, what: ProjectTask(
                id: projectTask.id,
                title: todoAddView.titleTextField.text!,
                description: todoAddView.descriptionTextView.text,
                date: todoAddView.deadLineDatePicker.date)
            )
        }
        self.dismiss(animated: true)
    }
    
    
    func setupLeftBarButtonItem() {
        var leftBarButtonItem: UIBarButtonItem
        switch state {
        case .TODO:
            leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        case .DOING:
            leftBarButtonItem = UIBarButtonItem(systemItem: .edit)
        case .DONE:
            leftBarButtonItem = UIBarButtonItem(systemItem: .edit)
        default:
            leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        }
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func configure() {
        guard let projectTask = projectTask else {
            return
        }
        todoAddView.titleTextField.text = projectTask.title
        todoAddView.deadLineDatePicker.date = projectTask.date
        todoAddView.descriptionTextView.text = projectTask.description
    }
    
    func extractCurrentTask() -> ProjectTask? {
        if isNewTask ?? false {
            return ProjectTask(
                id: UUID(),
                title: todoAddView.titleTextField.text ?? "",
                description: todoAddView.descriptionTextView.text,
                date: todoAddView.deadLineDatePicker.date
            )
        }
        guard let projectTask = projectTask else {
            return nil
        }
        return ProjectTask(
            id: projectTask.id,
            title: todoAddView.titleTextField.text ?? "",
            description: todoAddView.descriptionTextView.text,
            date: todoAddView.deadLineDatePicker.date
        )
    }
}
