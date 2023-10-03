//
//  SheetBackground.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/03.
//

import SwiftUI

struct SheetBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            ColorSet.navigationBarBackground.edgesIgnoringSafeArea(.all)
            Color.white
            content
        }
    }
}

extension View {
    func sheetBackground() -> some View {
        modifier(SheetBackground())
    }
}
