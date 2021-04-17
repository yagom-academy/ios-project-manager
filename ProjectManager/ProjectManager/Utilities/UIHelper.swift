import UIKit

final class UIHelper {
    static let shared = UIHelper()
    
    func configureCollectionLayout(with collectionView: ListCollectionView) -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: size)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = 8
        
        var listConfigration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfigration.headerMode = .supplementary
        listConfigration.backgroundColor = .systemGray6
        listConfigration.trailingSwipeActionsConfigurationProvider = { indexPath in
            guard let thing = collectionView.diffableDataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            let actionHandler: UIContextualAction.Handler = { action, view, completion in
                collectionView.deleteDataSource(thing: thing)
            }
            let action = UIContextualAction(style: .destructive, title: "Delete", handler: actionHandler)
            return UISwipeActionsConfiguration(actions: [action])
        }
        let layout = UICollectionViewCompositionalLayout.list(using: listConfigration)
        return layout
    }
}
