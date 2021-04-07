import UIKit

class ListCollectionView: UICollectionView {
    
    var things: [Thing] = []
    
    enum Section {
        case main
    }
    
    var collectionType: State
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Thing> = {
        return UICollectionViewDiffableDataSource<Section, Thing>(collectionView: self) { (collectionView, indexPath, Thing) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.contentView.backgroundColor = .white
            return cell
        }
    }()
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, collectionType: State) {
        self.collectionType = collectionType
        super.init(frame: frame, collectionViewLayout: layout)
        register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        backgroundColor = .systemGray6
        configureLayout()
        configureDataSource()
        // Hide scroll bar
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionViewLayout = layout
    }
    
    func configureDataSource() {
        var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Thing>()
        initialSnapShot.appendSections([.main])
        initialSnapShot.appendItems(self.things)
        
        diffableDataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
                return nil
            }
            supplementaryView.configure(headerType: self.collectionType)
            return supplementaryView
        }

        diffableDataSource.apply(initialSnapShot, animatingDifferences: false)
    }
    
    func updateDataSource(with thing: Thing) {
        self.things.append(thing)
        var snapShot = NSDiffableDataSourceSnapshot<Section, Thing>()
        snapShot.appendSections([.main])
        snapShot.appendItems(self.things)
        diffableDataSource.apply(snapShot)
    }
}
