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

            let lastIndexPath = IndexPath(item: self.viewModel?.countTaskList() ?? .zero - 1, section: 0)
            self.collectionView.insertItems(at: [lastIndexPath])
            self.collectionView.scrollToItem(at: lastIndexPath,
                                             at: UICollectionView.ScrollPosition.centeredHorizontally,
                                             animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}

extension TaskCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: view.bounds.size.height * 0.8)
    }
}
