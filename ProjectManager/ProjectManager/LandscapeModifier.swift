//
//  LandscapeModifier.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/27.
//

import SwiftUI

struct LandscapeModifier: ViewModifier {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    func body(content: Content) -> some View {
        content
            .previewLayout(.fixed(width: screenWidth, height: screenHeight))
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.verticalSizeClass, .regular)
    }
}

extension View {
    func landscape() -> some View {
        self.modifier(LandscapeModifier())
    }
}
