//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/30.
//

import UIKit

final class HistoryViewController: UIViewController {

    private enum Style {
        static let backgroundColor: UIColor = .systemBackground
        static let inset: CGFloat = 8

        static let subtitleTextColor: UIColor = .systemGray
    }

    let reusableCellIdentifier: String = "historyCell"

    var viewModel: HistoryViewModel?

    // MARK: Views

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Style.backgroundColor
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        tableView.dataSource = self
        setTableView()

        viewModel?.updated = { [weak self] in
            let insertedIndexPaths = [IndexPath(row: .zero, section: .zero)]
            DispatchQueue.main.async {
                self?.tableView.insertRows(at: insertedIndexPaths, with: .automatic)
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.setContentOffset(.zero, animated: false)
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
        return viewModel?.histories.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: reusableCellIdentifier)
        let history = viewModel?.history(at: indexPath.row)
        configure(cell, title: history?.title, subtitle: history?.subtitle)
        return cell
    }

    private func configure(_ cell: UITableViewCell, title: String?, subtitle: String?) {
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        cell.detailTextLabel?.textColor = Style.subtitleTextColor
    }
}
