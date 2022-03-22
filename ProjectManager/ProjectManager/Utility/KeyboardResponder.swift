//
//  KeyboardResponder.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/17.
//

import SwiftUI

final class KeyboardResponder: ObservableObject {
    
    @Published var currentHeight: CGFloat = 0
    private let center: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        self.center = center
        self.center.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.center.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyBoardWillShow(_ sender: Notification) {
        guard let userInfo = sender.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        withAnimation {
            currentHeight = keyboardHeight * 0.6
        }
    }
    
    @objc private func keyBoardWillHide() {
        withAnimation {
            currentHeight = 0
        }
    }
}
