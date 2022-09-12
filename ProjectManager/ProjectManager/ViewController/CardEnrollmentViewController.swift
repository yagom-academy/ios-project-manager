//
//  CardEnrollmentViewController.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

final class CardEnrollmentViewController: UIViewController {
    private enum Const {
        static let title = "TODO"
        static let cancel = "Cancel"
        static let done = "Done"
        static let stackViewSpacing = 10.0
        static let limitedTextAmount = 1000
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardModalView.leftBarButtonItem = UIBarButtonItem(title: Const.cancel,
        cardModalView.rightBarButtonItem = UIBarButtonItem(title: Const.done,
    }
}
