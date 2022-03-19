//
//  NavigationBarAppearanceModifier.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/20.
//

import SwiftUI

struct NavigationBarAppearanceModifier: ViewModifier {
    
    init(font: UIFont.TextStyle, foregroundColor: UIColor, tintColor: UIColor?, hideSeparator: Bool) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: font),
            .foregroundColor: UIColor.label
        ]
        if hideSeparator {
            navigationBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    
    /// NavigationBar 의 font, foregroundColor, tintColor 를 변경합니다. hideSeparator 를 true 로 바꾸면 Bar 의 경계선을 비활성화할 수 있습니다.
    func navigationBarAppearance(font: UIFont.TextStyle, foregroundColor: UIColor, tintColor: UIColor? = nil, hideSeparator: Bool = false) -> some View {
        self.modifier(NavigationBarAppearanceModifier(font: font, foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator))
    }
}
