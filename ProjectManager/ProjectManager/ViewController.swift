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
    
    lazy var todoCountLabel: UILabel = {
        let todoCountLabel: UILabel = UILabel()
        todoCountLabel.translatesAutoresizingMaskIntoConstraints = false
        todoCountLabel.backgroundColor = .black
        todoCountLabel.textColor = .white
        todoCountLabel.text = "0"
        todoCountLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        todoCountLabel.sizeToFit()
        todoCountLabel.textAlignment = .center
        return todoCountLabel
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
    
    lazy var doingCountLabel: UILabel = {
        let doingCountLabel: UILabel = UILabel()
        doingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        doingCountLabel.backgroundColor = .black
        doingCountLabel.textColor = .white
        doingCountLabel.text = "0"
        doingCountLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        doingCountLabel.sizeToFit()
        doingCountLabel.textAlignment = .center
        return doingCountLabel
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
    
    lazy var doneCountLabel: UILabel = {
        let doneCountLabel: UILabel = UILabel()
        doneCountLabel.translatesAutoresizingMaskIntoConstraints = false
        doneCountLabel.backgroundColor = .black
        doneCountLabel.textColor = .white
        doneCountLabel.text = "0"
        doneCountLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        doneCountLabel.sizeToFit()
        doneCountLabel.textAlignment = .center
        return doneCountLabel
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
        self.todoView.addSubview(todoCountLabel)
        self.doingView.addSubview(doingCountLabel)
        self.doneView.addSubview(doneCountLabel)
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
            doneLabel.leadingAnchor.constraint(equalTo: doneView.leadingAnchor, constant: 10),
            
            todoCountLabel.centerYAnchor.constraint(equalTo: todoLabel.centerYAnchor),
            todoCountLabel.leadingAnchor.constraint(equalTo: todoLabel.trailingAnchor, constant: 8),
            todoCountLabel.widthAnchor.constraint(equalTo: todoCountLabel.heightAnchor),
            doingCountLabel.centerYAnchor.constraint(equalTo: doingLabel.centerYAnchor),
            doingCountLabel.leadingAnchor.constraint(equalTo: doingLabel.trailingAnchor, constant: 8),
            doingCountLabel.widthAnchor.constraint(equalTo: doingCountLabel.heightAnchor),
            doneCountLabel.centerYAnchor.constraint(equalTo: doneLabel.centerYAnchor),
            doneCountLabel.leadingAnchor.constraint(equalTo: doneLabel.trailingAnchor, constant: 8),
            doneCountLabel.widthAnchor.constraint(equalTo: doneCountLabel.heightAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        todoCountLabel.layer.cornerRadius = todoCountLabel.frame.size.width
        todoCountLabel.layer.masksToBounds = true
        doingCountLabel.layer.cornerRadius = doingCountLabel.frame.size.width
        doingCountLabel.layer.masksToBounds = true
        doneCountLabel.layer.cornerRadius = doneCountLabel.frame.size.width
        doneCountLabel.layer.masksToBounds = true
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
