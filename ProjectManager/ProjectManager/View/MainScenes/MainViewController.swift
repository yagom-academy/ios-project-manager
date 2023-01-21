//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

protocol DataManageable: AnyObject {
    func shareData(data: Plan)
}

protocol EventManageable: AnyObject {
    func shareUpdateEvent(process: Process, index: Int?)
    func shareDeleteEvent(process: Process, index: Int)
}

protocol PopoverPresentable: AnyObject {
    func showPopover(
        process: Process,
        sender: UILongPressGestureRecognizer,
        cell: UITableViewCell,
        indexPath: IndexPath
    )
}

final class MainViewController: UIViewController {
    private enum UIConstant {
        static let navigationTitle = "Project Manager"
        static let tableSpacing = 10.0
        static let bottomValue = -50.0
    }
    
    private let viewModel = MainViewModel()
    private let todoView = ProcessView(viewModel: ProcessViewModel(process: .todo))
    private let doingView = ProcessView(viewModel: ProcessViewModel(process: .doing))
    private let doneView = ProcessView(viewModel: ProcessViewModel(process: .done))

    private lazy var mainStackView = UIStackView(
        views: [todoView, doingView, doneView],
        axis: .horizontal,
        alignment: .fill,
        distribution: .fillEqually,
        spacing: UIConstant.tableSpacing
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupNavigationBar()
        setupView()
        setupConstraint()
    }
    
    private func setupBinding() {
        viewModel.bindTodo { [weak self] data in
            self?.todoView.updateView(data)
        }
        
        viewModel.bindDoing { [weak self] data in
            self?.doingView.updateView(data)
        }
        
        viewModel.bindDone { [weak self] data in
            self?.doneView.updateView(data)
        }
    }
    
    private func presentDetailView() {
        let selectedData = viewModel.fetchSeletedData()
        let detailViewModel = DetailViewModel(data: selectedData)
        
        let detailViewController = DetailViewController(
            viewModel: detailViewModel
        )
        
        detailViewController.delegate = self
        detailViewController.modalPresentationStyle = .formSheet
        
        let detailNavigationController = UINavigationController(
            rootViewController: detailViewController
        )
        present(detailNavigationController, animated: true)
    }
}

// MARK: - Action
extension MainViewController {
    @objc private func addButtonTapped() {
        shareUpdateEvent(process: .todo, index: nil)
    }
}

// MARK: - DataSharable, EventManageable Delegate Protocol
extension MainViewController: DataManageable, EventManageable {
    func shareUpdateEvent(process: Process, index: Int?) {
        viewModel.prepareForEvent(process: process, index: index)
        
        presentDetailView()
    }
    
    func shareDeleteEvent(process: Process, index: Int) {
        viewModel.deleteData(process: process, index: index)
    }
    
    func shareData(data: Plan) {
        viewModel.updateData(data: data)
    }
}

// MARK: - PopoverPresentable Protocol
extension MainViewController: PopoverPresentable {
    func showPopover(
        process: Process,
        sender: UILongPressGestureRecognizer,
        cell: UITableViewCell,
        indexPath: IndexPath
    ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        viewModel.prepareForEvent(process: process, index: indexPath.row)
        
        viewModel.configureButtonProcess(process: process).forEach { process in
            let action = UIAlertAction(
                title: "Move To " + "\(process)",
                style: .default
            ) { [weak self] _ in
                self?.viewModel.changeProcess(after: process)
                self?.dismiss(animated: true)
            }
            alert.addAction(action)
        }
        
        guard let popover = alert.popoverPresentationController else { return }
        popover.sourceView = cell.contentView
        
        present(alert, animated: true)
    }
}

// MARK: - UI Configuration
extension MainViewController {
    private func setupNavigationBar() {
        title = UIConstant.navigationTitle
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        [todoView, doingView, doneView].forEach {
            $0.selectDataDelegate = self
            $0.presentDelegate = self
        }
    }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainStackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstant.bottomValue
            )
        ])
    }
}
