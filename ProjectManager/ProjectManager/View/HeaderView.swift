//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Toy on 1/24/24.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - Property
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, schedule: Schedule) {
        self.titleLabel.text = schedule.discription
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
