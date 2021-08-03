//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let todoHeadView = HeadView()
    private let doingHeadView = HeadView()
    private let doneHeadView = HeadView()

    private let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private let todoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()

    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private func setNavigation() {
        self.navigationItem.title = "Project Manager"
    }

    private func setMainView() {
        self.view.addSubview(headStackView)
        self.view.addSubview(tableStackView)
        self.view.backgroundColor = .systemBackground
    }

    private func setTableView() {
        [todoTableView, doingTableView, doneTableView].forEach { tableView in
            tableStackView.addArrangedSubview(tableView)
            tableView.delegate = self
        }

        [todoHeadView, doingHeadView, doneHeadView].forEach { headView in
            self.headStackView.addArrangedSubview(headView)
        }
    }

    private func setHeadView() {
        // TODO: setLabelText 메서드의 countNumber를 tableView의 자료 갯수만큼 카운트 하도록 변경 필요
        todoHeadView.setLabelText(classification: "TODO", countNumber: "1")
        doingHeadView.setLabelText(classification: "DOING", countNumber: "2")
        doneHeadView.setLabelText(classification: "DONE", countNumber: "3")

        headStackView.addArrangedSubview(todoHeadView)
        headStackView.addArrangedSubview(doingHeadView)
        headStackView.addArrangedSubview(doneHeadView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setMainView()

        headStackView.snp.makeConstraints { stackView in
            stackView.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        tableStackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(headStackView.snp.bottom)
            stackView.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        setHeadView()
        setTableView()
    }
}

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {

}

// MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
