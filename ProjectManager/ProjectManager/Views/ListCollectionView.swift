import UIKit

class ListCollectionView: UICollectionView {
    enum Section {
        case main
    }
    
    var collectionType: State
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Thing> = {
        return UICollectionViewDiffableDataSource<Section, Thing>(collectionView: self) { (collectionView, indexPath, thing) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            
            if self.checkIsDatePassed(thing.dueDate ?? 0.0) {
                cell.configure(thing: thing, datePassed: true)
            } else {
                cell.configure(thing: thing, datePassed: false)
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
    
    func checkIsDatePassed(_ date: Double) -> Bool {
        let currentDate = Date().timeIntervalSince1970
        if date < currentDate {
            return true
        } else {
            return false
        }
    }
}
