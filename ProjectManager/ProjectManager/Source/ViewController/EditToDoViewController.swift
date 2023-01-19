//  ProjectManager - EditToDoViewController.swift
//  created by zhilly on 2023/01/19

import UIKit

class EditToDoViewController: UIViewController {

    private enum Constant {
        static let title = "TODO"
        static let doneButtonTitle = "Done"
        static let cancelButtonTitle = "Cancel"
        static let editButtonTitle = "Edit"
        static let titlePlaceHolder = "Title"
        static let emptyTitle = "제목 없음"
        static let emptyBody = "내용 없음"
    }
    
    let viewModel: ToDoListViewModel
    private let currentToDo: ToDo
    private let detailView = ToDoDetailView()
    
    init(viewModel: ToDoListViewModel, toDo: ToDo) {
        self.viewModel = viewModel
        self.currentToDo = toDo
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupView()
        detailView.changeEditing(false)
    }
    
    private func configure() {
        title = Constant.title
        view.backgroundColor = .systemBackground
        
        let data = ToDoData(title: currentToDo.title,
                            body: currentToDo.body,
                            deadline: currentToDo.deadline)
        detailView.setupContent(data: data)
        
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
        let rightBarButton = UIBarButtonItem(title: Constant.doneButtonTitle,
                                             style: .done,
                                             target: self,
                                             action: #selector(tappedDoneButton))
        let leftBarButton = UIBarButtonItem(title: Constant.editButtonTitle,
                                            style: .done,
                                            target: self,
                                            action: #selector(tappedEditButton))
        
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    private func setupView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            detailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            detailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            detailView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
        ])
    }
    
    @objc
    private func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func tappedEditButton() {
        detailView.changeEditing(true)
        
        let leftBarButton = UIBarButtonItem(title: Constant.cancelButtonTitle,
                                            style: .done,
                                            target: self,
                                            action: #selector(tappedCancelButton))
        
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc
    private func tappedDoneButton() {
        dismiss(animated: true)
    }
}
