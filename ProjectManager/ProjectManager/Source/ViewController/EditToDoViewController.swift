//  ProjectManager - EditToDoViewController.swift
//  created by zhilly on 2023/01/19

import UIKit

final class EditToDoViewController: UIViewController {
    
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
    private let indexPath: Int
    private let status: ToDoState
    private let detailView = ToDoDetailView()
    
    init(viewModel: ToDoListViewModel, indexPath: Int, status: ToDoState) {
        self.viewModel = viewModel
        self.indexPath = indexPath
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = Constant.title
        view.backgroundColor = .systemBackground
        
        setupBarButtonItem()
        setupView()
        setupContent()
        detailView.changeEditing(false)
    }
    
    private func setupContent() {
        if let data = viewModel.fetchToDo(index: indexPath, state: self.status) {
            detailView.setupContent(data: data)
            return
        }
        
        let alert = UIAlertController(title: "데이터를 가져오는데 실패했습니다.",
                                      message: nil,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
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
        if detailView.validToDoTitle() == false {
            let alert = UIAlertController(title: "제목을 입력해주세요.", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: true)
            
            return
        }
        let data = detailView.currentContent()
        viewModel.update(currentState: self.status,
                         indexPath: indexPath,
                         title: data.title,
                         body: data.body,
                         deadline: data.deadline)
        
        dismiss(animated: true)
    }
}
