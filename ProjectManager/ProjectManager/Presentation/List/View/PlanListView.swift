//
//  PlanListView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

protocol PlanListView: UIView {
    var delegate: PlanListViewDelegate? { get set }
    var state: State { get }
}

extension PlanListView {
    var list: [PlanViewModel]? {
        return delegate?.configureList(state: state)
    }
}

protocol PlanListViewDelegate: UICollectionViewDelegate {
    func configureList(state: State) -> [PlanViewModel]
}
