//
//  UITextView+.swift
//  ProjectManager
//
//  Created by Moon on 2023/10/04.
//

import UIKit
import Combine

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextView } // 위 publisher의 리턴이 Notification이기 때문에 전달한 object(Any 타입)를 UITextView로 캐스팅
            .compactMap(\.text) // 위에서 캐스팅한 텍스트 뷰에서 text 추출
            .eraseToAnyPublisher() // 위에서 받은 text를 Publisher로 감쌈
    }
}
