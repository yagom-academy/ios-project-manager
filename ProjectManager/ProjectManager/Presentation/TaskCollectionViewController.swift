import UIKit

class TaskCollectionViewController: UICollectionViewController {
    var viewModel: TaskViewModelable?
    private let layout = UICollectionViewFlowLayout()


    init?(viewModel: TaskViewModelable) {
        self.viewModel = viewModel
        layout.itemSize = CGSize(width: 360, height: 900)
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
}
