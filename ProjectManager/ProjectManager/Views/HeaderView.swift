//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/07/13.
//

import UIKit

class HeaderView: UIView, TableViewConfigurable {
    
    var header: UIView = {
        let header = UIView()
        header.backgroundColor = .systemGray6
        header.translatesAutoresizingMaskIntoConstraints = false

        return header
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    var countLabel: UILabel = {
        let count = UILabel()
        count.textColor = .white
        count.text = "\(Task.todoList.count)"
        count.font = UIFont.preferredFont(forTextStyle: .title3)
        count.textAlignment = .center
        count.translatesAutoresizingMaskIntoConstraints = false

        return count
    }()
    
    var countView: UIView = {
        let countView = UIView()
        countView.backgroundColor = .black
        countView.translatesAutoresizingMaskIntoConstraints = false
        countView.clipsToBounds = true
        countView.layer.cornerRadius = 11.5

        return countView
    }()
}
