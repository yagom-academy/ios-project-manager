//
//  deleteDelegate.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/22.
//

import Foundation
import UIKit

protocol DeleteDelegate {
    func deleteTask(collectionView: UICollectionView, indexPath: IndexPath, taskID: String)
}
