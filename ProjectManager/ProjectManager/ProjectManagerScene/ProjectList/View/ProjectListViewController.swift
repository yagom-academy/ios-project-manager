//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import UIKit

final class ProjectListViewController: UIViewController {
    
    // MARK: - Private Property
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let headerView = HeaderView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Configure UI
extension ProjectListViewController {
    private func configureUI() {
        configureView()
        configureStackView()
        configureLayout()
    }
    
    private func configureView() {
        view.addSubview(stackView)
    }
    
    private func configureStackView() {
        [headerView, tableView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}

extension ProjectListViewController {
    private enum Section {
        case main
    }
}
