//
//  ProjectManagerCellStackView.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class CellStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configureCellStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCellStackView() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
