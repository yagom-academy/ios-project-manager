//
//  ProjectManagerStackView.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class ProjectManagerStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureProjectManagerStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureProjectManagerStackView() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
