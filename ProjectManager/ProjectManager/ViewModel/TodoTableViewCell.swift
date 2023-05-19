//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.preferredFont(forTextStyle: .title1)
        title.numberOfLines = 1
        
        return title
    }()
    
    private let body: UILabel = {
        let title = UILabel()
        title.textColor = .secondaryLabel
        title.font = UIFont.preferredFont(forTextStyle: .body)
        title.numberOfLines = 3
        
        return title
    }()
    
    private lazy var date: UILabel = {
        let title = UILabel()
        
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(body)
        stackView.addArrangedSubview(date)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configureCell(with item: TodoItem, and convertDate: String) {
        title.text = item.title
        body.text = item.body
        date.text = convertDate
    }
    
    func changeColor(by color: UIColor) {
        date.textColor = color
    }
}
