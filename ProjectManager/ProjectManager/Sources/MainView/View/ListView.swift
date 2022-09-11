//
//  ListView.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/12.
//

import UIKit

final class ListView: UIView {
    
    //MARK: - UI Properties
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "테스트 타이틀"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 0.5
        label.text = "999"
        return label
    }()
    
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUIComponents()
        setupListViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension ListView {
    
    //MARK: - Setup List View Initial State
    
    func addUIComponents() {
        self.addSubview(titleStackView)
        self.addSubview(mainTableView)
        
        titleStackView.addArrangedSubview(mainTitleLabel)
        titleStackView.addArrangedSubview(countLabel)
    }
    
    func setupListViewLayout() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
