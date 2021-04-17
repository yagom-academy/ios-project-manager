import UIKit

class ListCollectionView: UICollectionView {
    var collectionType: State
    var diffableDataSource: UICollectionViewDiffableDataSource<State, Thing>!
    private var things: [Thing]
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, collectionType: State) {
        self.collectionType = collectionType
        things = DataSource.shared.getDataByState(state: collectionType)

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
        register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionViewLayout = UIHelper.shared.configureCollectionLayout(with: self)
        showsVerticalScrollIndicator = false
    }
}

extension ListCollectionView {
    private func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<State, Thing>(collectionView: self, cellProvider: { [weak self] (collectionView, indexPath, thing) -> UICollectionViewCell? in
            guard let self = self,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.contentView.backgroundColor = .systemBackground
            cell.configure(thing: thing, datePassed: self.checkIsDatePassed(thing.dueDate ?? 0.0))
            return cell
        })
        
        diffableDataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self,
                  let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else {
                return nil
            }
            let count = self.diffableDataSource.collectionView(collectionView, numberOfItemsInSection: 0)
            supplementaryView.configure(headerType: self.collectionType, count: count)
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
    
    func updateThing(thing: Thing) {
        var snapshot = diffableDataSource.snapshot()
        snapshot.reloadItems([thing])
        diffableDataSource.apply(snapshot)
    }
    
    private func configureSnapshot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<State, Thing>()
        initialSnapshot.appendSections([collectionType])
        initialSnapshot.appendItems(things)
        diffableDataSource.apply(initialSnapshot, animatingDifferences: true)
    }
    
    private func checkIsDatePassed(_ date: Double) -> Bool {
        let currentDate = Date().timeIntervalSince1970
        if date < currentDate {
            return true
        } else {
            return false
        }
    }
}
