//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Jinho Choi on 2021/03/12.
//

import UIKit

class TableHeaderView: UIView {
    private let contentsContainerView = UIView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    let cellCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContainerView()
        configureAutoLayout()
        configureShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpContainerView() {
        addSubview(contentsContainerView)
        contentsContainerView.addSubview(titleLabel)
        contentsContainerView.addSubview(cellCountLabel)
        self.backgroundColor = .systemGray6
    }
    
    private func configureAutoLayout() {
        contentsContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentsContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            contentsContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentsContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            contentsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentsContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentsContainerView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentsContainerView.bottomAnchor),

            cellCountLabel.centerYAnchor.constraint(equalTo: contentsContainerView.centerYAnchor),
            cellCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            cellCountLabel.widthAnchor.constraint(equalToConstant: 40),
            cellCountLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureShadow() {
        self.layer.shadowColor = UIColor.systemGray4.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 1
    }
    
    func fillHeaderViewText(itemStatus: ItemStatus) {
        titleLabel.text = itemStatus.title
        cellCountLabel.text = String(ItemList.shared.countListItem(statusType: itemStatus))
    }
}
