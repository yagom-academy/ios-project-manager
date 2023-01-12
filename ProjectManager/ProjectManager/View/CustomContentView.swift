//
//  CustomContentView.swift
//  ProjectManager
//
//  Created by Jiyoung Lee on 2023/01/13.
//

import UIKit

class CustomContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
