//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    typealias Text = Constant.Text
    
    var viewModel: DetailViewModel?
    var delegate: DetailProjectDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIComponent()
    }
    
    private func configureUIComponent() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    private func configureNavigationBar() {
        navigationItem.title = viewModel?.fetchNavigationTitle()
        navigationItem.leftBarButtonItem = makeLeftButton()
        navigationItem.rightBarButtonItem = makeDoneButton()
    }

    private func configureViewHierarchy() {
        
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func configureHandler() {
        viewModel?.bindEditable { isEditable in
            if isEditable == true {
                self.navigationItem.leftBarButtonItem = self.makeLeftButton()
            }
        }
    }
    
    private func makeDoneButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .done,
                                     primaryAction: tappedDoneButtonAction())

        return button
    }
    
    private func tappedDoneButtonAction() -> UIAction {
        let action = UIAction { _ in
            self.delegate?.detailProject(willSave: Project())
            self.dismiss(animated: true)
        }

        return action
    }
    
    private func makeLeftButton() -> UIBarButtonItem {
        let button: UIBarButtonItem
        switch viewModel?.isEditable == true {
        case true:
            button = UIBarButtonItem(systemItem: .cancel,
                                     primaryAction: tappedCancelButtonAction())
        case false:
            button = UIBarButtonItem(systemItem: .edit,
                                     primaryAction: tappedEditButtonAction())
        }
        
        return button
    }
    
    private func tappedCancelButtonAction() -> UIAction {
        let action = UIAction { _ in
            self.dismiss(animated: true)
        }

        return action
    }
    
    private func tappedEditButtonAction() -> UIAction {
        let action = UIAction { _ in
            self.viewModel?.changeEditable(state: true)
        }

        return action
    }
    
    private func saveProjectIfValid() {
//        guard viewModel?.validateDeadline(date: <#T##Date#>) == true else {
//            showAlert(message: Text.invalidDeadlineMessage)
//        }
//        let project = viewModel?.makeProject(title: <#T##String#>, description: <#T##String#>, deadline: <#T##Date#>)
//        delegate?.detailProject(willSave: project)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let doneAction = UIAlertAction(title: Text.doneButton,
                                       style: .default)
        alert.addAction(doneAction)

        present(alert, animated: true, completion: nil)
    }
}

extension DetailViewController: DetailProject { }
