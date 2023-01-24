//  ProjectManager - ToDoHeaderView.swift
//  created by zhilly on 2023/01/16

import UIKit

final class ToDoHeaderView: UIView {
    
    private let status: ToDoState
    private let count: Int
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = status.description
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var listCountLabel: ItemCountLabel = {
        let label = ItemCountLabel(count: self.count)
        
        return label
    }()
    
    init(status: ToDoState, count: Int) {
        self.status = status
        self.count = count
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        listCountLabel.layer.cornerRadius = listCountLabel.bounds.size.height * 0.5
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
