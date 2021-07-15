//
//  ProjectManagerStackView.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

final class ProcessListsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureProcessListsStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureProcessListsStackView() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
