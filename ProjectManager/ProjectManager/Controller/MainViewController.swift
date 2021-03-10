//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlet
    
    lazy var todoTableView = makeTableView()
    lazy var doingTableView = makeTableView()
    lazy var doneTableView = makeTableView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureConstratins()
        registerNotificationCentor()
    }
    
    // MARK: - UI
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ThingTableViewCell.self, forCellReuseIdentifier: ThingTableViewCell.identifier)
        return tableView
    }
    
    private func configureConstratins() {
        let safeArea = view.safeAreaLayoutGuide
        let stackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Strings.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
    }
    
    // MARK: - DetailView
    
    @objc private func touchUpAddButton() {
        showDetailView(isNew: true)
    }
    
    private func showDetailView(isNew: Bool = false, tableViewType: TableViewType = .todo, index: Int? = nil, thing: Thing? = nil) {
        let detailView = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailView)
        detailView.isNew = isNew
        detailView.title = tableViewType.rawValue
        detailView.tableViewType = tableViewType
        detailView.index = index
        detailView.thing = thing
        present(navigationController, animated: true, completion: nil)
    }
    
    private func registerNotificationCentor() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Strings.reloadNotification, object: nil)
    }
    
    @objc func reloadTableView() {
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    // MARK: - TableView
    
    private func makeHeaderView(tableViewType: TableViewType, thingCount: Int) -> UIView {
        let headerView = UIView()
        let titleLabel = makeHeaderText(tableViewType: tableViewType, thingCount: thingCount)
        
        headerView.backgroundColor = .systemGroupedBackground
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
        ])
        return headerView
    }
    
    private func makeHeaderText(tableViewType: TableViewType, thingCount: Int) -> UILabel {
        let titleLabel = UILabel()
        let attributedString = NSMutableAttributedString(string: tableViewType.rawValue)
        let numberCircle = NSTextAttachment()
        
        if thingCount <= 50 {
            let imageName = String(format: Strings.numberCirclerImage, thingCount)
            numberCircle.image = UIImage(systemName: imageName)
            attributedString.append(NSAttributedString(attachment: numberCircle))
        } else {
            let plusImage = NSTextAttachment()
            numberCircle.image = UIImage(systemName: Strings.fiftyNumberCircle)
            attributedString.append(NSAttributedString(attachment: numberCircle))
            plusImage.image = UIImage(systemName: Strings.plusImage)
            attributedString.append(NSAttributedString(attachment: plusImage))
        }
        
        titleLabel.attributedText = attributedString
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
}

// MARK: - Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == todoTableView {
            return makeHeaderView(tableViewType: .todo, thingCount: Things.shared.todoList.count)
        } else if tableView == doingTableView {
            return makeHeaderView(tableViewType: .doing, thingCount: Things.shared.doingList.count)
        } else {
            return makeHeaderView(tableViewType: .done, thingCount: Things.shared.doneList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == todoTableView {
            let thing = Things.shared.todoList[indexPath.row]
            showDetailView(index: indexPath.row, thing: thing)
        } else if tableView == doingTableView {
            let thing = Things.shared.doingList[indexPath.row]
            showDetailView(tableViewType: .doing, index: indexPath.row, thing: thing)
        } else {
            let thing = Things.shared.doneList[indexPath.row]
            showDetailView(tableViewType: .done, index: indexPath.row, thing: thing)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == todoTableView {
                Things.shared.todoList.remove(at: indexPath.row)
            } else if tableView == doingTableView {
                Things.shared.doingList.remove(at: indexPath.row)
            } else {
                Things.shared.doneList.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
    }
}


// MARK: - DataSoure

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return Things.shared.todoList.count
        } else if tableView == doingTableView {
            return Things.shared.doingList.count
        } else {
            return Things.shared.doneList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThingTableViewCell.identifier) as? ThingTableViewCell else {
            return UITableViewCell()
        }
        if tableView == todoTableView {
            cell.configureCell(Things.shared.todoList[indexPath.row])
        } else if tableView == doingTableView {
            cell.configureCell(Things.shared.doingList[indexPath.row])
        } else {
            cell.isDone = true
            cell.configureCell(Things.shared.doneList[indexPath.row])
        }
        return cell
    }
}
