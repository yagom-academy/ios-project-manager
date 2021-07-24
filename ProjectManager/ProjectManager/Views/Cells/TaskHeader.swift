//
//  TaskCollectionViewHeaderCell.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/21.
//

import UIKit

final class TaskHeader: UIView {
    var status: String?
    var count: Int?
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setStatusLabelConstraint()
        setCountViewConstraint()
        setCountLabelConstraint()
        initializeHeaderConfigure(title)
    }
    
    private func initializeHeaderConfigure(_ title: String) {
        self.statusLabel.text = title
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.systemGray4.cgColor
    }
    
    func updateCount(_ count: Int) {
        countLabel.text = String(count)
    }
    
    private func setStatusLabelConstraint() {
        self.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setCountViewConstraint() {
        addSubview(countView)
        NSLayoutConstraint.activate([
            countView.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 10),
            countView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            countView.heightAnchor.constraint(equalTo: statusLabel.heightAnchor, constant: -5),
            countView.widthAnchor.constraint(equalTo: countView.heightAnchor)
        ])
    }
    
    private func setCountLabelConstraint() {
        countView.addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor)
        ])
    }
}
