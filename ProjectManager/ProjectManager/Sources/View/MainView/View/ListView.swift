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
        
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
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
        label.font = .preferredFont(forTextStyle: .title3)
        label.layer.backgroundColor = UIColor.black.cgColor
        label.textColor = .white
        label.layer.cornerRadius = 7
        label.text = "99"
        return label
    }()
    
    private let titleSpacingView: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
      }()
    
    private let tableSpacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainTableView.register(ProjectTaskCell.self, forCellReuseIdentifier: MainViewCommand.cellReuseIdentifier)
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
        self.addSubview(tableSpacingView)
        self.addSubview(mainTableView)
        
        titleStackView.addArrangedSubview(mainTitleLabel)
        titleStackView.addArrangedSubview(countLabel)
        titleStackView.addArrangedSubview(titleSpacingView)
    }
    
    func setupListViewLayout() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tableSpacingView.topAnchor.constraint(equalTo: self.titleStackView.bottomAnchor),
            tableSpacingView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableSpacingView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableSpacingView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: tableSpacingView.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
