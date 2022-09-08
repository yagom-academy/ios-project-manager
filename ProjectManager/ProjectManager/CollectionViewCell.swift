//
//  CollectionViewCell.swift
//  ProjectManager
//
//  Created by 전민수 on 2022/09/08.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    private var customView: UIView {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(customView)
        
//        NSLayoutConstraint.activate([
//            customView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            customView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//            customView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            customView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
//        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
