//
//  UITextField+Combine.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { self.text ?? "" }
            .eraseToAnyPublisher()
    }
}
