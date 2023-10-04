//
//  KeyboardManager.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/27.
//

import SwiftUI
import Combine

class KeyboardManager: ObservableObject {
    @Published var height: CGFloat = 0
    @Published var isVisible: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillShowNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] notification in
                guard let self = self else { return }

                guard let userInfo = notification.userInfo else { return }
                guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                withAnimation {
                    self.height = keyboardFrame.height
                    self.isVisible = true
                }
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillHideNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                withAnimation {
                    self.height = 0
                    self.isVisible = false
                }
            }
            .store(in: &cancellables)
    }

    func hide() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
