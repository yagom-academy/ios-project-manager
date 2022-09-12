//
//  CardDetailViewController.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

final class CardDetailViewController: UIViewController {
    private enum Const {
        static let title = "TODO"
        static let edit = "Edit"
        static let editing = "Editing"
        static let done = "Done"
        static let stackViewSpacing = 10.0
        static let limitedTextAmount = 1000
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardModalView.leftBarButtonItem = UIBarButtonItem(title: Const.edit,
        cardModalView.rightBarButtonItem = UIBarButtonItem(title: Const.done,
    }
}
