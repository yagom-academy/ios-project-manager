//
//  UITextView+publisher.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/25.
//

import UIKit
import Combine

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification,
                                             object: self)
            .compactMap { $0.object as? UITextView }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
