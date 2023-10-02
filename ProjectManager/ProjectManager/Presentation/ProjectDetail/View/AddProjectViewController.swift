//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by Erikc on 2023/09/26.
//

import UIKit

final class AddProjectViewController: ProjectDetailViewController {
    
    // MARK: - Life Cycle
    override init(viewModel: ProjectDetailViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View event
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc private func tapCancelButton() {
        dismiss(animated: true)
    }
}

// MARK: - Configure UI
extension AddProjectViewController {
    private func configureUI() {
        configureNavigation()
    }
    
    private func configureNavigation() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelButton))
        
        navigationItem.leftBarButtonItem = cancelButton
    }
}
