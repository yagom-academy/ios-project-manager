//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa
import CoreMIDI

final class MainViewController: UIViewController, UIGestureRecognizerDelegate {

// MARK: - Properties
    var viewModel: MainViewModel?

    private let bag = DisposeBag()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    private let tableViews: [UITableView] = Progress.allCases.map { _ in UITableView() }
    private let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "+"
        return barButton
    }()
    private let longPressGestureRecognizers: [UILongPressGestureRecognizer] = Progress.allCases.map { _ in
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.minimumPressDuration = 0.7
        return longPressGestureRecognizer
    }

// MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }

    override func viewWillAppear(_ animated: Bool) {


    }
}

// MARK: - Private Methods

private extension MainViewController {

    func configure() {
        self.view.backgroundColor = .white
        self.configureNavigationBar()
        self.configureSubView()
    }

    func configureSubView() {
        self.configureHierarchy()
        self.configureConstraint()
        self.configureTableView()
        self.binding()
    }

    func configureHierarchy() {
        self.view.addSubview(stackView)
        self.tableViews.forEach { tableView in
            self.stackView.addArrangedSubview(tableView)
        }
    }

    func configureNavigationBar() {
        self.title = "ProjectManager"
        self.navigationItem.rightBarButtonItem = addBarButton
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard let tableView = longPressGestureRecognizer.view as? UITableView else {
            return
        }
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    func configureTableView() {
        self.tableViews.forEach { tableView in
            tableView.register(cellWithClass: ScheduleListCell.self)
            tableView.delegate = self
        }
        self.configureTableViewGestureRecognizers()
    }

    func configureTableViewGestureRecognizers() {
        self.tableViews.enumerated().forEach { index, tableView in
            tableView.addGestureRecognizer(self.longPressGestureRecognizers[index])
        }
    }

    func showActionSheet() {
        let actionSheet = UIAlertController(title: "이동", message: nil, preferredStyle: .actionSheet)
        let first = UIAlertAction(title: "Move to DOING", style: .default, handler: nil)
        let second = UIAlertAction(title: "Move to DONE", style: .default, handler: nil)
        actionSheet.addAction(first)
        actionSheet.addAction(second)
    }

    func binding() {
        self.tableViewBinding()
    }

    func tableViewBinding() {

        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: nil)
        longPressGesture.minimumPressDuration = 1.0

        self.tableViews.forEach {
            $0.addGestureRecognizer(longPressGesture)
        }
        let input = MainViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear))
                .map { _ in },
            tableViewLongPressed: self.longPressGestureRecognizers.map { gestureRecognizer in
                gestureRecognizer.rx.event
                    .map { (gestureRecognizer: UIGestureRecognizer) -> Schedule? in
                        guard let tableView = gestureRecognizer.view as? UITableView else {
                            return nil
                        }

                        if gestureRecognizer.state == .began {
                            let touchPoint = gestureRecognizer.location(in: tableView)
                            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                                return try tableView.rx.model(at: indexPath)
                            }
                        }
                        return nil
                    }.asObservable()
            }
            ,
            cellDidTap: self.tableViews.map { $0.rx.modelSelected(Schedule.self).asObservable() },
            cellDelete: self.tableViews.map { $0.rx.modelDeleted(Schedule.self).map { $0.id! } },
            addButtonDidTap: self.addBarButton.rx.tap.asObservable()
        )

        guard let output = self.viewModel?.transform(input: input, disposeBag: self.bag) else {
            return
        }

        output.scheduleLists.enumerated().forEach { index, observable in
            observable.asDriver()
                .drive(
                    self.tableViews[index].rx.items(
                        cellIdentifier: "ScheduleListCell",
                        cellType: ScheduleListCell.self
                    )
                ) { _, item, cell in
                    cell.configureContent(with: item)
                }
                .disposed(by: bag)
        }
    }
}

// MARK: - TableView Delegate Method

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
