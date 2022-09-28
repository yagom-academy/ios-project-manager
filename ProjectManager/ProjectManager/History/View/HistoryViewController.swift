//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import UIKit

class HistoryViewController: UIViewController {
    var viewModel = HistoryViewModel()

    @IBOutlet weak var historyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        historyTableView.reloadData()
    }
}

extension HistoryViewController: SendDelegate,ReuseIdentifying {
    func sendData<T>(_ data: T) {
        guard let data = data as? SendModel else {
            return
        }

        viewModel.add(data: data)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(
            withIdentifier: HistoryTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? HistoryTableViewCell else {
            return UITableViewCell()
        }

        cell.setUpCell(data: viewModel.contents[indexPath.row])
        return cell
    }
}
