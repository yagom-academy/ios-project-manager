//
//  PlanViewController.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/15.
//

import UIKit

class PlanViewController: UIViewController {

    private let viewModel: PlanViewModel

    init(viewModel: PlanViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
