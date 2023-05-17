//
//  ToDoTableViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    private var toDoListViewModel: TodoListViewModel
    private let workState: WorkState
    
    init(toDoListViewModel: TodoListViewModel, workState: WorkState) {
        self.toDoListViewModel = toDoListViewModel
        self.workState = workState
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListViewModel.numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell
        else { return UITableViewCell() }
        
        let todoViewModel = toDoListViewModel.todo(at: indexPath.row)
        cell.textLabel?.text = todoViewModel?.title

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = self.workState.text
        let badgeView = UILabel()
        badgeView.text = "5"
        badgeView.backgroundColor = .black
        badgeView.textColor = .white
        badgeView.layer.cornerRadius = 50
        let titleStackView = UIStackView(arrangedSubviews: [label, badgeView])
        
        return titleStackView
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
}
