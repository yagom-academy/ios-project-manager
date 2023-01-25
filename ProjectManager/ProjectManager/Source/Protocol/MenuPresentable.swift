//
//  MenuPresentable.swift
//  ProjectManager
//  Created by inho on 2023/01/18.
//

import UIKit

protocol MenuPresentable: UIViewController {
    func didLongPressGesture(_ sender: UIGestureRecognizer, _ viewModel: ListItemCellViewModel)
}
