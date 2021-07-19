//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

class KanBanBoardViewController: UIViewController {
    // 3개의 datasource
    let toDoArray = ["todo", "todo", "totoo"]
    let doingArray = ["doing", "doing", "doingggg"]
    let doneArray = ["done", "done", "doneee"]

    let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    let toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
       return tableView
    }()

    let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
       return tableView
    }()

    let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
       return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self

        view.addSubview(outerStackView)

        outerStackView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        outerStackView.addArrangedSubview(toDoTableView)
        outerStackView.addArrangedSubview(doingTableView)
        outerStackView.addArrangedSubview(doneTableView)

    }
}

extension KanBanBoardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 각각의 table마다 분기처리를 통해 data를 넣어주는 방식
        switch tableView {

        case self.toDoTableView:
            return toDoArray.count

        case self.doingTableView:
            return doingArray.count

        case self.doneTableView:
            return doneArray.count

        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KanBanBoardCell.reuseIdentifier,
            for: indexPath
        ) as? KanBanBoardCell
        else {
            return UITableViewCell()
        }

        switch tableView {
        case self.toDoTableView:
            cell.titleLabel.text = toDoArray[indexPath.row]
        case self.doingTableView:
            cell.titleLabel.text = doingArray[indexPath.row]
        case self.doneTableView:
            cell.titleLabel.text = doneArray[indexPath.row]
        default:
            break
        }

        return cell
    }
}
