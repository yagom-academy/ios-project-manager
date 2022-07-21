//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class ProjectTableView: UITableView {
    private let headerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.sizeToFit()
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        
        func round() {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 15
        }
        
        func text() {
            label.textColor = .white
            label.text = "0"
            label.textAlignment = .center
            label.font = .preferredFont(forTextStyle: .body)
        }
        
        round()
        text()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero, style: .grouped)
        
        setUpLayout()
        setUpTitle(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(headerView)
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
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpTitle(title: String) {
        listTitleLabel.text = title
    }
    
    func setUpCountLabel(count: Int) {
        countLabel.text = String(count)
    }
}
