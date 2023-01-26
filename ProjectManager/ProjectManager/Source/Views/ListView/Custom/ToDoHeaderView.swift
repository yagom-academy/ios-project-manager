//  ProjectManager - ToDoHeaderView.swift
//  created by zhilly on 2023/01/16

import UIKit

class ToDoHeaderView: UITableViewHeaderFooterView, ReusableView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var listCountLabel: ItemCountLabel = .init(frame: .zero)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: Self.reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(status: ToDoState, count: Int) {
        titleLabel.text = status.description
        listCountLabel.updateCount(with: count)
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(listCountLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listCountLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            listCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            listCountLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
