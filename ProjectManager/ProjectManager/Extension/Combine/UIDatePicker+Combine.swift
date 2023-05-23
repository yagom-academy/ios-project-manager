//
//  UIDatePicker+Combine.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import UIKit
import Combine

extension UIDatePicker {
    var datePublisher: AnyPublisher<Date, Never> {
        publisher(for: .valueChanged)
            .map { self.date }
            .print()
            .eraseToAnyPublisher()
    }
}
