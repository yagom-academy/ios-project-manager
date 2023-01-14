//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    var viewModel = MainViewModel()
    let lists: [ListView] = [ListView(), ListView(), ListView()]
    var dataSources: [DataSource?] = [nil, nil, nil]
    let listStack = UIStackView(distribution: .fillEqually,
                                spacing: 5,
                                backgroundColor: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpNavigationBar()
        configureDataSource()
        takeInitialSnapShot()
        configureLists()
        bidingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpListTitles()
        configureHierarchy()
        configureLayout()
    }
        
    func configureDataSource() {
        Process.allCases.forEach { process in
            dataSources[process.index] = generateDataSource(process: process)
        }
    }
    
    func generateDataSource(process: Process) -> DataSource {
        return DataSource(tableView: lists[process.index].tableView) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
                as? ListCell
            
            cell?.setupViews(process: process, viewModel: ListCellViewModel(project: item))

            return cell
        }
    }
    
    func takeInitialSnapShot() {
        dataSources.enumerated().forEach { index, dataSource in
            dataSource?.applyInitialSnapShot(viewModel.datas[index])
        }
    }
    
    func bidingViewModel() {
        viewModel.updateData = { [weak self] process, data, count in
            guard let self = self else { return }
            
            self.dataSources[process.index]?.applySnapshot(data)
            self.lists[process.index].countLabel.text = count
        }
    }
    
    func setUpListTitles() {
        lists.enumerated().forEach { index, listView in
            listView.titleLabel.text = viewModel.processTitles[index]
        }
    }
}

// MARK: NavigationBar
extension MainViewController {
    
    func setUpNavigationBar() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                        primaryAction: touchedUpBarButtonAction())
        
        self.navigationController?.navigationBar.topItem?.title = "Project Manager"
        self.navigationController?.navigationBar.topItem?.setRightBarButton(barButton,
                                                                            animated: true)
    }
    
    func touchedUpBarButtonAction() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            let editingViewModel = EditingViewModel(editTargetModel: self.viewModel)
            let editViewController = EditingViewController(viewModel: editingViewModel)
            editViewController.modalPresentationStyle = .formSheet
            
            self.navigationController?.present(editViewController, animated: true)
        }
    }
}

// MARK: Layout
extension MainViewController {
    
    func configureHierarchy() {
        lists.forEach {
            listStack.addArrangedSubview($0)
        }
        
        view.addSubview(listStack)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            listStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            listStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func configureLists() {
        lists.forEach {
            $0.tableView.delegate = self
            $0.tableView.backgroundColor = .secondarySystemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.opacity = 0.3
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView = view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return  UIView()
    }
}
