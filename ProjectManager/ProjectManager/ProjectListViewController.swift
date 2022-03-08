//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by 권나영 on 2022/03/02.
//

import UIKit

protocol TodoEditDelegate: AnyObject {
    func showTaskViewController(with: Todo)
    func moveToTodo(with: Todo)
    func moveToDoing(with: Todo)
    func moveToDone(with: Todo)
}

class ProjectListViewController: UIViewController {
    
    var todoList: [Todo] = []
    weak var delegate: TodoEditDelegate?
    let step: Step
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(step: Step) {
        self.step = step
        super.init(nibName: nil, bundle: nil)
        setupTableView()
        configureTableViewLayout()
        addLongPressGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .systemGray6
    }
    
    func configureTableViewLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func append(_ todo: Todo) {
        todoList.append(todo)
        tableView.reloadData()
    }
    
    func addLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                showRelocateMenu(touchPoint: touchPoint, indexPath: indexPath)
            }
        }
    }
    
    func showRelocateMenu(touchPoint: CGPoint, indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let todo = todoList[indexPath.row]
        
        let firstAction = UIAlertAction(title: "Move to Doing", style: .default) { _ in
            switch self.step {
            case .todo:
                self.delegate?.moveToDoing(with: todo)
            case .doing:
                self.delegate?.moveToDone(with: todo)
            case .done:
                self.delegate?.moveToTodo(with: todo)
            }
            
            self.todoList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let secondAction = UIAlertAction(title: "Move to Done", style: .default) { _ in
            switch self.step {
            case .todo:
                self.delegate?.moveToDone(with: todo)
            case .doing:
                self.delegate?.moveToTodo(with: todo)
            case .done:
                self.delegate?.moveToDoing(with: todo)
            }
            
            self.todoList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        actionSheet.addAction(firstAction)
        actionSheet.addAction(secondAction)
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: touchPoint.x, y: touchPoint.y, width: 0, height: 0)
        actionSheet.popoverPresentationController?.permittedArrowDirections = [.up]
        
        if var topController = UIApplication.shared.connectedScenes
                                                    .compactMap({ $0 as? UIWindowScene })
                                                    .flatMap({ $0.windows })
                                                    .first(where: { $0.isKeyWindow })?
                                                    .rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(actionSheet, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TodoCell else {
            return UITableViewCell()
        }
        cell.configureUI(todo: todoList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView  = UIView()
        headerView.backgroundColor = .systemGray6
        
        let titleLabel = UILabel()
        titleLabel.text = step.rawValue
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        let countLabel = UILabel()
        countLabel.text = String(todoList.count)
        countLabel.textColor = .white
        countLabel.backgroundColor = .black
        countLabel.textAlignment = .center
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.layer.masksToBounds = true
        countLabel.layer.cornerRadius = 12
        headerView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 18),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -18),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor, multiplier: 1)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        delegate?.showTaskViewController(with: todo)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - TodoAddDelegate

extension ProjectListViewController: TodoAddDelegate {
    func addTodo(data: Todo) {
        todoList.append(data)
        tableView.reloadData()
    }
}
