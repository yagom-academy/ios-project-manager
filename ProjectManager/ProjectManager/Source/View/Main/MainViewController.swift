//
//  ProjectManager - MainViewController.swift
//  Created by songjun, vetto. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let mainViewModel = MainViewModel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .lightGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var todoView = DoListView(viewModel: mainViewModel, type: .todo)
    private lazy var doingView = DoListView(viewModel: mainViewModel, type: .doing)
    private lazy var doneView = DoListView(viewModel: mainViewModel, type: .done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoView.collectionView.delegate = self
        doingView.collectionView.delegate = self
        doneView.collectionView.delegate = self
        configureUI()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let buttonItem: UIBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(tabPlusButton))
            
            return button
        }()
        
        navigationItem.rightBarButtonItem = buttonItem
        self.title = "ProjectManager"
    }
    
    @objc func tabPlusButton() {
        presentAddModal()
    }
    
    private func presentAddModal() {
        let modalViewController = ModalViewController(viewModel: mainViewModel, modalType: .add)
        let modalNavigationController = UINavigationController(rootViewController: modalViewController)
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.preferredContentSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.7)
        
        present(modalNavigationController, animated: true, completion: nil)
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(doingView)
        stackView.addArrangedSubview(doneView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modalViewController = ModalViewController(viewModel: mainViewModel, modalType: .edit, indexPathRow: indexPath.row)
        let modalNavigationController = UINavigationController(rootViewController: modalViewController)
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.preferredContentSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.7)
        
        present(modalNavigationController, animated: true, completion: nil)
    }
}
