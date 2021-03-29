import UIKit

class ListCollectionView: UICollectionView {
    enum Section {
        case main
    }
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Int> = {
        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: self) { (collectionView, indexPath, number) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.configure(number: number)
            cell.backgroundColor = .systemPink
            return cell
        }
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)
        backgroundColor = .systemBackground
        configureLayout()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(36))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionViewLayout = layout
    }
    
    func configureDataSource() {
        var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapShot.appendSections([.main])
        initialSnapShot.appendItems(Array(1...7))

        diffableDataSource.apply(initialSnapShot, animatingDifferences: false)
    }
}
