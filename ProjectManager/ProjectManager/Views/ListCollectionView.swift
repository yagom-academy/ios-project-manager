import UIKit

class ListCollectionView: UICollectionView {
    enum Section {
        case main
    }
    
    var collectionType: State
    var things: [Thing] = [Thing(id: 1, title: "Self-sizing 고민해보기", description: "Lorem Ipsum is simply dummy text.", state: .todo, dueDate: 0.0, updatedAt: 0.0), Thing(id: 2, title: "DiffableDataSource 공부해보기", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a ty≥pe specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", state: .todo, dueDate: 0.0, updatedAt: 0.0)]
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Thing> = {
        return UICollectionViewDiffableDataSource<Section, Thing>(collectionView: self) { (collectionView, indexPath, thing) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.contentView.backgroundColor = .white
            cell.configure(thing: thing)
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
}

extension ListCollectionView {
    private func configureLayout() {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: size)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionViewLayout = layout
    }

    private func configureDataSource() {
        var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Thing>()
        initialSnapShot.appendSections([.main])
        initialSnapShot.appendItems(things)

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
