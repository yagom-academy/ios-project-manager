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
    var state: ProjectTaskState?
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
    
    //MARK: - Navigation Item Setup
    
    func setupNavigationBarItem() {
        view.backgroundColor = .systemGray5
        setupNavigationItems()
    }
    
    func setupNavigationItems() {
        let naviItem = UINavigationItem(title: state?.rawValue ?? "")
        naviItem.leftBarButtonItem = setupLeftBarButtonItem()
        naviItem.rightBarButtonItem =  setupRightBarButtonItem()
        todoAddView.navigationBar.setItems([naviItem], animated: true)
    }
    
    func setupRightBarButtonItem() -> UIBarButtonItem {
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped))
        return rightBarButtonItem
    }
    
    func setupLeftBarButtonItem() -> UIBarButtonItem {
        var leftBarButtonItem: UIBarButtonItem
        
        if isNewTask == nil {
            leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .edit,
                target: self,
                action: #selector(editButtonDidTapped)
            )
        } else {
            leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(cancelButtonDidTapped)
            )
        }
        return leftBarButtonItem
    }
    
    @objc func doneButtonDidTapped() {
        if isNewTask != nil {
            guard let extractedTask = extractCurrentTask() else {
                return
            }
            
            viewModel?.createTask(to: extractedTask, at: .TODO)
        } else {
            editButtonDidTapped()
        }
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonDidTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func editButtonDidTapped() {
        guard let projectTask = projectTask,
            let state = state else {
            return
        }
        
        viewModel?.updateTask(at: state, what: ProjectTask(
            id: projectTask.id,
            title: todoAddView.titleTextField.text!,
            description: todoAddView.descriptionTextView.text,
            date: todoAddView.deadLineDatePicker.date)
        )
        self.dismiss(animated: true)
    }
    
    //MARK: - Model configure
    
    func configure() {
        guard let projectTask = projectTask, isNewTask == nil else {
            return
        }
        
        todoAddView.titleTextField.text = projectTask.title
        todoAddView.deadLineDatePicker.date = projectTask.date
        todoAddView.descriptionTextView.text = projectTask.description
    }
    
    func extractCurrentTask() -> ProjectTask? {
       if isNewTask != nil {
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
