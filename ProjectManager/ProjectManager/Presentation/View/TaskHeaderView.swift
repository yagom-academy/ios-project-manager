//
//  TaskHeaderView.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import UIKit

class TaskHeaderView: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EF_Diary", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let projectCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 12.5
        label.widthAnchor.constraint(equalToConstant: 25).isActive = true
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI(title: String, count: Int) {
        titleLabel.text = title
        projectCountLabel.text = String(count)
    }
    
    private func configureLayout() {
        [titleLabel, projectCountLabel].forEach {
            headerStackView.addArrangedSubview($0)
        }
        contentView.addSubview(headerStackView)
        contentView.backgroundColor = UIColor(red: 236/256, green: 192/256, blue: 224/256, alpha: 1)
    }
}
