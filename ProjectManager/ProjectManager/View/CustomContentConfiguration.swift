//
//  CustomContentConfiguration.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/13.
//

import UIKit

struct CustomContentConfiguration: UIContentConfiguration {
    var status: Status?
    var title: String?
    var body: String?
    var dueDate: Date?
    
    func makeContentView() -> UIView & UIContentView {
        return CustomContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
