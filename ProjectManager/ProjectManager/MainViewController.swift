//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    
    private var todoTableView = UITableView(frame: .zero, style: .grouped)
    private var doingTableView = UITableView(frame: .zero, style: .grouped)
    private var doneTableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.backgroundColor = .systemGroupedBackground
        doingTableView.backgroundColor = .systemGroupedBackground
        doneTableView.backgroundColor = .systemGroupedBackground
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
          navigationController?.isToolbarHidden = false
          navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
          navigationItem.title = String.navigationBarTitle
      }
    
    @objc private func touchUpAddButton() {
        showDetailView()
        configureMainView()
    }
    
    private func showDetailView() {
        print("showDetail")
    }
    
    private func configureMainView() {
            let stackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
            let safeArea = view.safeAreaLayoutGuide
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            stackView.backgroundColor = .systemGray2
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
        }
}

