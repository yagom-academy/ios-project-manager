//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {

    let projectManagerStackView = ProjectManagerStackView()
    let toDoStackView = MemoStackView()
    let doingStackView = MemoStackView()
    let doneStackView = MemoStackView()
    
    let todoTitleView = MemoTitleView()
    let doingTitleView = MemoTitleView()
    let doneTitleView = MemoTitleView()
    
    let toDoTableView = UITableView()
    let doingTableView = UITableView()
    let doneTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        title = "소개팅 필승 공략"
        
        configureStackView()
        configureProjectManagerTableView()
        
        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
        
        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        todoTitleView.layer.addBorder([.bottom], color: .systemGray4, width: 1.5)
        doingTitleView.layer.addBorder([.bottom], color: .systemGray4, width: 1.5)
        doneTitleView.layer.addBorder([.bottom], color: .systemGray4, width: 1.5)
    }
    
    private func configureProjectManagerTableView() {
        toDoStackView.addArrangedSubview(todoTitleView)
        toDoStackView.addArrangedSubview(toDoTableView)
        doingStackView.addArrangedSubview(doingTitleView)
        doingStackView.addArrangedSubview(doingTableView)
        doneStackView.addArrangedSubview(doneTitleView)
        doneStackView.addArrangedSubview(doneTableView)
        
        toDoTableView.showsVerticalScrollIndicator = false
        doingTableView.showsVerticalScrollIndicator = false
        doneTableView.showsVerticalScrollIndicator = false
        
        todoTitleView.title.text = "TODO"
        todoTitleView.count.text = "5"
        doingTitleView.title.text = "DOING"
        doingTitleView.count.text = "5"
        doneTitleView.title.text = "DONE"
        doneTitleView.count.text = "5"
        
        todoTitleView.title.font = UIFont.boldSystemFont(ofSize: 30)
        doingTitleView.title.font = UIFont.boldSystemFont(ofSize: 30)
        doneTitleView.title.font = UIFont.boldSystemFont(ofSize: 30)
        
        todoTitleView.count.textColor = .systemBackground
        doingTitleView.count.textColor = .systemBackground
        doneTitleView.count.textColor = .systemBackground
        
        todoTitleView.count.backgroundColor = .black
        doingTitleView.count.backgroundColor = .black
        doneTitleView.count.backgroundColor = .black
        
        todoTitleView.count.textAlignment = .center
        doingTitleView.count.textAlignment = .center
        doneTitleView.count.textAlignment = .center
        
        todoTitleView.count.layer.cornerRadius = 12.5
        todoTitleView.count.layer.masksToBounds = true
        
        projectManagerStackView.addArrangedSubview(toDoStackView)
        projectManagerStackView.addArrangedSubview(doingStackView)
        projectManagerStackView.addArrangedSubview(doneStackView)
        
        toDoTableView.tableFooterView = UIView(frame: .zero)
        doingTableView.tableFooterView = UIView(frame: .zero)
        doneTableView.tableFooterView = UIView(frame: .zero)
        
        toDoTableView.backgroundColor = .systemGray6
        doingTableView.backgroundColor = .systemGray6
        doneTableView.backgroundColor = .systemGray6
        
        toDoTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
        doingTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
        doneTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
    }
}

// MARK: -StackView AutoLayout
extension ProjectManagerViewController {
    
    private func configureStackView() {
        view.addSubview(projectManagerStackView)
        
        NSLayoutConstraint.activate([
            projectManagerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectManagerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            projectManagerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectManagerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension CALayer {
    
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom: border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left: border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right: border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}


