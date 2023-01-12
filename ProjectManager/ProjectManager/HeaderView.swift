//
//  HeaderView.swift
//  ProjectManager
//
//  Created by jin on 1/12/23.
//

import UIKit

class HeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 25/2
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        self.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(countLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 25),
            countLabel.heightAnchor.constraint(equalToConstant: 25)
        ])

    }

    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }

    func setItemCount(_ number: Int) {
        self.countLabel.text = number.description
    }
}
