//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/30.
//

import UIKit

final class HistoryViewController: UIViewController {

    private enum Style {
        static let inset: CGFloat = 8
    }

    var viewModel: HistoryViewModel?

    // MARK: Views

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        tableView.dataSource = self
        setTableView()

        viewModel?.updated = { [weak self] index in
            let insertedIndexPaths = [IndexPath(row: index, section: 0)]
            DispatchQueue.main.async {
                self?.tableView.insertRows(at: insertedIndexPaths, with: .automatic)
            }
        }
    }

    // MARK: Configure

    private func setTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style.inset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Style.inset),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Style.inset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Style.inset)
        ])
    }
}

// MARK: - UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "historyCell")
        return cell
    }
}
