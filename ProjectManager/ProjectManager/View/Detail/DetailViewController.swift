//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/21.
//

import UIKit

final class DetailViewController: UIViewController {
    private enum ViewMode {
        case add
        case edit
    }
    
    private var viewMode: ViewMode?
    var viewModel: WorkViewModel? // 고민중
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIOption()
    }
    
    func configureAddMode() {
        viewMode = .add
    }
    
    func configureEditMode() {
        viewMode = .edit
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = "TODO"
    }
}
