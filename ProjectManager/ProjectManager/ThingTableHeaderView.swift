//
//  ThingTableHeaderView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/10.
//

import UIKit

class ThingTableHeaderView: UIView {
    private let titleLabel = UILabel()
    private let countLabel = UILabel()

    init(height: Int, title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        addSubview(titleLabel)
        addSubview(countLabel)
        configureConstraints()
        setStyle()
        titleLabel.text = title
        countLabel.text = String(0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
    }
    
    private func setStyle() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        countLabel.font = UIFont.systemFont(ofSize: 15)
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .black
        // TODO: 자리수가 넘어가도 원형이 잘 유지되는지?
        countLabel.layer.cornerRadius = 10
        countLabel.layer.masksToBounds = true
        backgroundColor = .systemGray5
    }
    
    func setCount(_ count: Int) {
        countLabel.text = String(count)
    }
}
