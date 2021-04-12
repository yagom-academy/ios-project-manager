import UIKit

class ListCollectionView: UICollectionView {
    enum Section {
        case main
    }
    
    var collectionType: State
    var things: [Thing]
    var diffableDataSource: UICollectionViewDiffableDataSource<State, Thing>!

    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, collectionType: State) {
        self.collectionType = collectionType
        self.things = DataSource.shared.getDataByState(state: collectionType)
        
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
        configureDataSource()
        configureSnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        backgroundColor = .systemGray6
        register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionViewLayout = UIHelper.shared.configureCollectionLayout()
        self.showsVerticalScrollIndicator = false
    }
}

extension ListCollectionView {
    private func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<State, Thing>(collectionView: self, cellProvider: { (collectionView, indexPath, thing) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.contentView.backgroundColor = .white
            if self.checkIsDatePassed(thing.dueDate ?? 0.0) {
                cell.configure(thing: thing, datePassed: true)
            } else {
                cell.configure(thing: thing, datePassed: false)
            }
            return cell
        })
        
        diffableDataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
                return nil
            }
            supplementaryView.configure(headerType: self.collectionType)
            return supplementaryView
        }
    }
    
    func insertDataSource(thing: Thing, state: State) {
        var snapshot = diffableDataSource.snapshot()
        snapshot.appendItems([thing], toSection: state)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func deleteDataSource(thing: Thing) {
        var snapshot = diffableDataSource.snapshot()
        snapshot.deleteItems([thing])
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func reorderDataSource(destinationIndexPath: IndexPath, thing: Thing) {
        var snapshot = diffableDataSource.snapshot()

        if let lastItem = diffableDataSource.itemIdentifier(for: destinationIndexPath) {
            snapshot.insertItems([thing], beforeItem: lastItem)
        } else {
            snapshot.appendItems([thing])
        }
        
        diffableDataSource.apply(snapshot)
    }
    
    private func configureSnapshot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<State, Thing>()
        initialSnapshot.appendSections([collectionType])
        initialSnapshot.appendItems(things)
        diffableDataSource.apply(initialSnapshot, animatingDifferences: true)
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
