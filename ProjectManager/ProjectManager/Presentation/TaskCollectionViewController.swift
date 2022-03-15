import UIKit

final class TaskCollectionViewController: UICollectionViewController {
    private var viewModel: TaskViewModelable?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.reloadTaskList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setViewModel(_ viewModel: TaskViewModelable) {
        self.viewModel = viewModel
    }

    @IBAction func addListBarButtonDidTap(_ sender: Any) {
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
        self.viewModel?.taskLists.append(TaskList(title: taskListTitle))

        let lastIndexOfTaskList = (self.viewModel?.countOfTaskList() ?? .zero) - 1
        let lastIndexPath = IndexPath(item: lastIndexOfTaskList, section: 0)

        self.collectionView.insertItems(at: [lastIndexPath])
        self.collectionView.scrollToItem(at: lastIndexPath,
                                         at: UICollectionView.ScrollPosition.centeredHorizontally,
                                         animated: true)
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {}
}

extension TaskCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.countOfTaskList() ?? .zero
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TaskCollectionViewCell else { return UICollectionViewCell() }
        guard let task = viewModel?.fetchTaskList(at: indexPath.item) else { return UICollectionViewCell() }
        cell.configure(with: task)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: view.bounds.size.height * 0.8)
    }
}
