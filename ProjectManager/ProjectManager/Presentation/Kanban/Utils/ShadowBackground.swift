//
//  ShadowBackground.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 9/26/23.
//

import SwiftUI

struct ShadowBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background {
                Rectangle()
                    .fill(.background)
                    .shadow(color: .secondary, radius: 3, x: 2, y: 2)
            }
    }
}

extension View {
    func shadowBackground() -> some View {
        modifier(ShadowBackground())
    }
}
