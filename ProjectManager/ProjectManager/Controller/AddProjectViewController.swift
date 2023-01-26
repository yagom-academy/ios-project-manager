//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by jin on 1/16/23.
//

import UIKit

protocol TaskAddDelegate: AnyObject {
    func taskDidAdded(_ task: Task)
}

class AddProjectViewController: UIViewController {

    enum Constant {
        static let datePickerWidth: CGFloat = 400
        static let navigationTitle = "TODO"
        static let titleTextFieldPlaceHolder = "Title"
        static let stackViewSpacing: CGFloat = 10
    }
    
    let taskSettingView = TaskSettingView()
    weak var delegate: TaskAddDelegate?

    // MARK: - LifeCycle
    override func loadView() {
        view = taskSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        configureNavigationItem()
    }
    
    func configureNavigationItem() {
        navigationItem.title = Constant.navigationTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCurrentViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveAndDismissCurrentViewController))
    }

    // MARK: - Selectors
    @objc private func dismissCurrentViewController() {
        self.dismiss(animated: true)
    }

    @objc private func saveAndDismissCurrentViewController() {
        guard let task = taskSettingView.fetchTask() else {
            return
        }
        delegate?.taskDidAdded(task)
        self.dismissCurrentViewController()
    }
    // MARK: - Helpers
}
