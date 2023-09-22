//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    private let TODOTitleView: TitleView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        
        return titleView
    }()
    
    private let DOINGTitleView: TitleView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        
        return titleView
    }()
    
    private let DONETitleView: TitleView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        
        return titleView
    }()
    
    private let leftTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "leftTableView")
        tableView.tag = 1
        
        
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let centerTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "centerTableView")
        tableView.tag = 2
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let rightTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "rightTableView")
        tableView.tag = 3
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        configureLayout()

    }
    
    private func configureView() {
        view.backgroundColor = .systemGray6
        leftTableView.delegate = self
        leftTableView.dataSource = self
        centerTableView.delegate = self
        centerTableView.dataSource = self
        rightTableView.delegate = self
        rightTableView.dataSource = self
        view.addSubview(TODOTitleView)
        view.addSubview(DOINGTitleView)
        view.addSubview(DONETitleView)
        view.addSubview(leftTableView)
        view.addSubview(centerTableView)
        view.addSubview(rightTableView)
        
    }
    
    func configureNavigation() {
        let plusBotton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(tappedPlusButton))
        navigationItem.rightBarButtonItem = plusBotton
        navigationItem.title = "Project Manager"
        
    }
    

    @objc private func tappedPlusButton() {
        
    }
    
    private func configureLayout() {
        let viewWidth = view.safeAreaLayoutGuide.layoutFrame.width / 3.0
        
        NSLayoutConstraint.activate([
            leftTableView.topAnchor.constraint(equalTo: TODOTitleView.bottomAnchor, constant: 8),
            leftTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            leftTableView.trailingAnchor.constraint(equalTo: centerTableView.leadingAnchor),
            leftTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            leftTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            
            centerTableView.topAnchor.constraint(equalTo: DOINGTitleView.bottomAnchor, constant: 8),
            centerTableView.leadingAnchor.constraint(equalTo: leftTableView.trailingAnchor),
//            centerTableView.trailingAnchor.constraint(equalTo: rightTableView.leadingAnchor),
            centerTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            centerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            rightTableView.topAnchor.constraint(equalTo: DONETitleView.bottomAnchor, constant: 8),
            rightTableView.leadingAnchor.constraint(equalTo: centerTableView.trailingAnchor),
            rightTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rightTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            TODOTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            TODOTitleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            TODOTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            TODOTitleView.bottomAnchor.constraint(equalTo: leftTableView.topAnchor),
            
            DOINGTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DOINGTitleView.leadingAnchor.constraint(equalTo: leftTableView.trailingAnchor),
            DOINGTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            DOINGTitleView.bottomAnchor.constraint(equalTo: centerTableView.topAnchor),
            
            DONETitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DONETitleView.leadingAnchor.constraint(equalTo: centerTableView.trailingAnchor),
            DONETitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            DONETitleView.bottomAnchor.constraint(equalTo: rightTableView.topAnchor)
            
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return 1
        } else if tableView.tag == 2 {
            return 2
        } else if tableView.tag == 3 {
            return 3
        }
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return TableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 10
//    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//       return
//    }
    
    
}
