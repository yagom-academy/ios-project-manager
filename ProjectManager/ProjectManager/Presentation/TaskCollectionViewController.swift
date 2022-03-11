import UIKit

class TaskCollectionViewController: UICollectionViewController {
    private var viewModel: TaskViewModelable?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.didLoaded()
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
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let titleName = alertController.textFields?.first?.text, titleName.isNotEmpty else { return }
            self.viewModel?.taskLists.append(TaskListEntity(title: titleName))

            let lastIndexOfTaskList = (self.viewModel?.countTaskList() ?? .zero) - 1
            let lastIndexPath = IndexPath(item: lastIndexOfTaskList, section: 0)

            self.collectionView.insertItems(at: [lastIndexPath])
            self.collectionView.scrollToItem(at: lastIndexPath,
                                             at: UICollectionView.ScrollPosition.centeredHorizontally,
                                             animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {}
}

extension TaskCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.countTaskList() ?? .zero
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath) as? TaskCollectionViewCell else { return UICollectionViewCell() }
        if let task = viewModel?.taskLists[indexPath.item] {
            cell.configure(with: task)
            cell.parentViewController = self
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: view.bounds.size.height * 0.8)
    }
}
