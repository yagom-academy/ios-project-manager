//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Jinho Choi on 2021/03/12.
//

import UIKit

class HeaderView: UIView {
    private let containerView = UIView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    let cellCountLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.frame.width * 0.5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContainerView()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpContainerView() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cellCountLabel)
    }
    
    private func configureAutoLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            cellCountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cellCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            cellCountLabel.widthAnchor.constraint(equalTo: cellCountLabel.heightAnchor),
            cellCountLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
    
    func fillHeaderViewText(itemStatus: ItemStatus) {
        titleLabel.text = itemStatus.title
        cellCountLabel.text = "15"
    }
}
