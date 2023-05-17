//
//  TaskHeaderView.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/18.
//

import UIKit

final class TaskHeaderView: UICollectionReusableView {
    
    let titleLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    let contentsInfoLabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .black
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 25 / 2
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


