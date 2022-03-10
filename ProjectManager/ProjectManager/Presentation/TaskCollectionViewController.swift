import UIKit

class TaskCollectionViewController: UICollectionViewController {
    var viewModel: TaskViewModelable?
    private let layout = UICollectionViewFlowLayout()


    init?(viewModel: TaskViewModelable) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView(with: view.bounds.size)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.didLoaded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        configureCollectionView(with: size)
    }

    private func configureCollectionView(with size: CGSize) {
        layout.itemSize = CGSize(width: 360, height: size.height * 0.8)
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


