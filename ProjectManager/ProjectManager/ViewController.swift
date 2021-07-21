//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    lazy var todoTableView: UITableView = {
        let todoTableView: UITableView = UITableView()
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        return todoTableView
    }()
    
    lazy var doingTableView: UITableView = {
        let doingTableView: UITableView = UITableView()
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        return doingTableView
    }()
    
    lazy var doneTableView: UITableView = {
        let doneTableView: UITableView = UITableView()
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        return doneTableView
    }()
    
    lazy var todoView: UIView = {
        let todoView: UIView = UIView()
        todoView.translatesAutoresizingMaskIntoConstraints = false
        // 아래 코드는 구현을 위한 코드 (todoLabel frame)
        // frame과 bounds 의 차이 -> todoLabel 오토레이아웃 관점에서 어떤식으로 하는게 더 좋을지?
        todoView.backgroundColor = .systemGray6
        return todoView
    }()
    
    lazy var todoLabel: UILabel = {
        let todoLabel: UILabel = UILabel()
        todoLabel.translatesAutoresizingMaskIntoConstraints = false
        todoLabel.text = "TODO"
        todoLabel.sizeToFit()
//        todoLabel.font = todoLabel.font.withSize()
        todoLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return todoLabel
    }()
    
    lazy var doingView: UIView = {
        let doingView: UIView = UIView()
        doingView.translatesAutoresizingMaskIntoConstraints = false
        doingView.backgroundColor = .systemGray6
        return doingView
    }()
    
    lazy var doingLabel: UILabel = {
        let doingLabel: UILabel = UILabel()
        doingLabel.translatesAutoresizingMaskIntoConstraints = false
        doingLabel.text = "DOING"
        doingLabel.sizeToFit()
        doingLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return doingLabel
    }()
    
    lazy var doneView: UIView = {
        let doneView: UIView = UIView()
        doneView.translatesAutoresizingMaskIntoConstraints = false
        doneView.backgroundColor = .systemGray6
        return doneView
    }()
    
    lazy var doneLabel: UILabel = {
        let doneLabel: UILabel = UILabel()
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        doneLabel.text = "DONE"
        doneLabel.sizeToFit()
        doneLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return doneLabel
    }()
    
    lazy var titlesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [todoView, doingView, doneView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    lazy var tablesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    private func addSubViews() {
        self.view.addSubview(titlesStackView)
        self.view.addSubview(tablesStackView)
        self.todoView.addSubview(todoLabel)
        self.doingView.addSubview(doingLabel)
        self.doneView.addSubview(doneLabel)
    }
    
    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tablesStackView.topAnchor.constraint(equalTo: titlesStackView.bottomAnchor),
            tablesStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tablesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tablesStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            titlesStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titlesStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titlesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            todoLabel.topAnchor.constraint(equalTo: todoView.topAnchor, constant: 15),
            todoLabel.bottomAnchor.constraint(equalTo: todoView.bottomAnchor, constant: -15),
            todoLabel.leadingAnchor.constraint(equalTo: todoView.leadingAnchor, constant: 10),
            doingLabel.topAnchor.constraint(equalTo: doingView.topAnchor, constant: 15),
            doingLabel.bottomAnchor.constraint(equalTo: doingView.bottomAnchor, constant: -15),
            doingLabel.leadingAnchor.constraint(equalTo: doingView.leadingAnchor, constant: 10),
            doneLabel.topAnchor.constraint(equalTo: doneView.topAnchor, constant: 15),
            doneLabel.bottomAnchor.constraint(equalTo: doneView.bottomAnchor, constant: -15),
            doneLabel.leadingAnchor.constraint(equalTo: doneView.leadingAnchor, constant: 10)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.view.backgroundColor = .white
        addSubViews()
        configureConstraints()
    }
}
