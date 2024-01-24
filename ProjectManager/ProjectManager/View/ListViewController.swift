//
//  ListViewController.swift
//  ProjectManager
//
//  Created by Toy on 1/24/24.
//

import UIKit

final class ListViewController: UINavigationController {
    // MARK: - Property
    private let tableView = UITableView()
    private let scheduleType: Schedule
    
    init(scheduleType: Schedule) {
        self.scheduleType = scheduleType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupTableView()
    }
    
    // MARK: - Helper
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource Method
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// MARK: - UITableViewDelegate Method
extension ListViewController: UITableViewDelegate {
    
}
