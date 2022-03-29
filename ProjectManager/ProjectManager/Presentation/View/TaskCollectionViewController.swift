import UIKit

final class TaskCollectionViewController: UICollectionViewController {
    private var viewModel: TaskViewModel?
    private var taskListIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPrefetchingEnabled = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setViewModel(_ viewModel: TaskViewModel) {
        self.viewModel = viewModel
        self.viewModel?.observer = self
    }

    @IBAction private func addListBarButtonDidTap(_ sender: Any) {
        let alertController = UIAlertController(title: "Add A List", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        configureCancelAction(in: alertController)
        configureAddAction(in: alertController)
        present(alertController, animated: true)
    }

    private func configureCancelAction(in alertController: UIAlertController) {
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }

    private func configureAddAction(in alertController: UIAlertController) {
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let taskListTitle = alertController.textFields?.first?.text,
                  taskListTitle.isNotEmpty else { return }
            self.insertItem(in: taskListTitle)
        })
    }

    private func insertItem(in taskListTitle: String) {
        self.viewModel?.addNewTaskList(with: taskListTitle)
        updateTaskListUI()
    }

    private func updateTaskListUI() {
        let lastIndexOfTaskList = (self.viewModel?.countOfTaskList() ?? .zero) - 1
        let lastIndexPath = IndexPath(item: lastIndexOfTaskList, section: 0)

        self.collectionView.insertItems(at: [lastIndexPath])
        self.collectionView.scrollToItem(at: lastIndexPath,
                                         at: UICollectionView.ScrollPosition.centeredHorizontally,
                                         animated: true)
    }
}

extension TaskCollectionViewController: TaskCollectionViewCellDelegate {
    func presentTaskDetailModal(taskListIndex: Int, taskIndex: Int?) {
        guard let detailViewController = storyboard?.instantiateViewController(identifier: "TaskDetailViewController")
                as? TaskDetailViewController else { return }

        if let taskIndex = taskIndex,
           var task = viewModel?.fetchTask(at: taskIndex, in: taskListIndex) {
            detailViewController.setValue(title: task.title, dueDate: task.dueDate, body: task.body)
            detailViewController.updateData = { [weak self] (title, dueDate, body) in
                task.title = title
                task.dueDate = dueDate
                task.body = body
                self?.viewModel?.updateTask(task, in: taskListIndex)}
        } else {
            detailViewController.updateData = { [weak self] (title, dueDate, body) in
                self?.viewModel?.addNewTask(title: title,
                                            dueDate: dueDate,
                                            body: body,
                                            in: taskListIndex)}
        }
        present(detailViewController, animated: true, completion: nil)
    }

    func present(controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }

    func deleteTask(at index: Int, taskListIndex: Int) {
        if let id = viewModel?.searchTaskID(by: index, in: taskListIndex) {
            viewModel?.deleteTask(taskID: id, in: taskListIndex)
        }
    }
}

extension TaskCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = viewModel?.countOfTaskList() ?? .zero
        return index
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuseIdentifier,
                                                         for: indexPath) as? TaskCollectionViewCell,
           let taskListName = viewModel?.titleOfTaskList(by: indexPath.row) {
            cell.delegate = self
            cell.configureCell(with: viewModel, taskListName, taskListIndex: indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: view.bounds.size.height * 0.8)
    }
}

extension TaskCollectionViewController: TaskViewModelObserver {
    func updated() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
