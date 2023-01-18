//
//  ListFormViewController.swift
//  ProjectManager
//  Created by inho on 2023/01/15.
//

import UIKit

class ListFormViewController: UIViewController {
    // MARK: Properties
    
    private let listFormView = ListFormView()
    var delegate: ListFormViewControllerDelegate?
    var formViewModel: ListFormViewModel?
    var isAdding: Bool {
        return formViewModel == nil ? true : false
    }
    
    // MARK: Initializer
    
    init(formViewModel: ListFormViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.formViewModel = formViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAdding {
            configureAddNavigationBar()
        } else {
            configureEditNavigationBar()
            bindHandler()
            configureViews()
        }
        configureLayout()
    }
    
    // MARK: Private Methods
    
    private func configureAddNavigationBar() {
        navigationItem.leftBarButtonItem = .init(
            title: Constant.cancelButton,
            style: .plain,
            target: self,
            action: #selector(cancelButtonPressed)
        )
        navigationItem.title = Constant.todo
        navigationItem.rightBarButtonItem = .init(
            title: Constant.doneButton,
            style: .done,
            target: self,
            action: #selector(addNewItem)
        )
    }
    
    private func configureEditNavigationBar() {
        let title: String
        
        switch formViewModel?.listType {
        case .todo:
            title = Constant.todo
        case .doing:
            title = Constant.doing
        case .done:
            title = Constant.done
        default:
            return
        }
        
        navigationItem.leftBarButtonItem = .init(
            title: Constant.editButton,
            style: .plain,
            target: self,
            action: #selector(editButtonPressed)
        )
        navigationItem.title = title
        navigationItem.rightBarButtonItem = .init(
            title: Constant.doneButton,
            style: .done,
            target: self,
            action: #selector(doneEditPressed)
        )
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(listFormView)
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            listFormView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listFormView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            listFormView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listFormView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func bindHandler() {
        formViewModel?.bindEditHandler({
            if $0 == true {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
            }
        })
    }
    
    private func configureViews() {
        guard let viewModel = formViewModel else { return }

        listFormView.configureViews(using: viewModel.listItem)
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editButtonPressed() {
        formViewModel?.toggleEditMode()
    }
    
    @objc func addNewItem() {
        let newItem = ListItem(
            title: listFormView.currentTitle,
            body: listFormView.currentBody,
            dueDate: listFormView.currentDate
        )
        
        delegate?.addNewItem(newItem)
        dismiss(animated: true)
    }
    
    @objc func doneEditPressed() {
        guard let viewModel = formViewModel else { return }

        delegate?.ediItem(
            of: viewModel.listType,
            at: viewModel.index,
            title: listFormView.currentTitle,
            body: listFormView.currentBody,
            dueDate: listFormView.currentDate
        )
        dismiss(animated: true)
    }
}

// MARK: - NameSpace

private enum Constant {
    static let todo = "TODO"
    static let doing = "DOING"
    static let done = "DONE"
    
    static let cancelButton = "Cancel"
    static let editButton = "Edit"
    static let doneButton = "Done"
}
