//
//  UICollectionView+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<Cell: UICollectionViewCell>(cellType: Cell.Type, for indexPath: IndexPath) -> Cell
    where Cell: ReusableCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }

        return cell
    }
}
