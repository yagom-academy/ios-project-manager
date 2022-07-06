//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private lazy var baseStackView = UIStackView(
        arrangedSubviews: [
            todoTableView,
            doingTableView,
            doneTableView
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    
    private lazy var todoTableView = UITableView()
    private lazy var doingTableView = UITableView()
    private lazy var doneTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)

        view.backgroundColor = .systemGray4
        title = "Project Manager"
        let plusButton = UIBarButtonItem(
            image: UIImage(
                systemName: "plus"
            ),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = plusButton
        
        setupSubViews()
        setupUILayout()
    }
    
    private func setupSubViews() {
        view.addSubview(baseStackView)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Method
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let todoCell = todoTableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        ) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        return todoCell
    }
}
