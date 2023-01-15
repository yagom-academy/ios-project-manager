//
//  PlanListView.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/15.
//

import UIKit

protocol PlanListView: UIView {
    var delegate: PlanListViewDelegate? { get set }
    var state: PlanState { get }
}

extension PlanListView {
    var list: [PlanViewModel]? {
        return delegate?.configureList(state: state)
    }
}

protocol PlanListViewDelegate: UICollectionViewDelegate {
    func configureList(state: PlanState) -> [PlanViewModel]
}
