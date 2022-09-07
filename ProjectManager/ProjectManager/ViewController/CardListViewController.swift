//
//  ProjectManager - CardListViewController.swift
//  Created by Derrick kim.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CardListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    private var viewModel: CardViewModelProtocol?
    
    init(viewModel: CardViewModelProtocol, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.title = "Project Manager"
    }
}
