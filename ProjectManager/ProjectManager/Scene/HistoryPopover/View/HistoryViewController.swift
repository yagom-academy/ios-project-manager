//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import UIKit

import RxSwift

final class HistoryViewController: UIViewController {
    private let viewModel: HistoryViewModel
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()

    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.setUpView()
        self.setUpTableView()
        self.setUpConstraints()
        self.bind()
    }

    private func setUpView() {
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = .systemGray5
        self.dynamicContentsSize()
    }

    private func setUpTableView() {
        self.tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }

    private func dynamicContentsSize() {
        self.preferredContentSize = CGSize(width: 500, height: 700)
    }

    func bind() {
        self.viewModel.historyData
            .asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items) { tableView, row, element in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: HistoryCell.identifier,
                    for: IndexPath(row: row, section: .zero)) as? HistoryCell else {
                    return UITableViewCell()
                }
                cell.configure(element)

                return cell
            }
            .disposed(by: self.disposeBag)
    }
}
