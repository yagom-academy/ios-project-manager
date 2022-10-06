//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import UIKit

class HistoryViewController: UIViewController {
    // MARK: Properties
    var viewModel = HistoryViewModel()

    // MARK: IBAction
    @IBOutlet weak var historyTableView: UITableView!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        historyTableView.reloadData()
    }
}

// MARK: extension - SendDelegate
extension HistoryViewController: SendDelegate,ReuseIdentifying {
    func sendData<T>(_ data: T) {
        guard let data = data as? [History] else {
            return
        }

        viewModel.add(data: data)
    }
}

// MARK: extension - UITableViewDelegate
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
