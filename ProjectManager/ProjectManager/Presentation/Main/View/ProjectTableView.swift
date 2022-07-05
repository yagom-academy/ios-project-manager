//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class ProjectTableView: UITableView {
    init() {
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.sizeToFit()
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.bounds.height / 2
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
        super.init(frame: .zero, style: .grouped)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        headerView.addSubview(listTitleLabel)
        headerView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            listTitleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            listTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            listTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: listTitleLabel.topAnchor),
            countLabel.bottomAnchor.constraint(equalTo: listTitleLabel.bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: listTitleLabel.trailingAnchor, constant: 10),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }
    
    private func setUpHeader() {
        tableHeaderView = headerView
    }
    
    private func setUpTitle(title: String) {
        listTitleLabel.text = title
    }
    
    func setUpCountLabel(count: Int) {
        countLabel.text = String(count)
    }
}
