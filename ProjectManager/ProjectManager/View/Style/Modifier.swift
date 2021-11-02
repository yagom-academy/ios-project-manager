//
//  View.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/01.
//

import SwiftUI

extension View {
    func backgroundColor(_ color: Color?) -> some View {
        self.background(Rectangle().foregroundColor(color))
    }

    func swipe(deleteAction: @escaping () -> Void) -> some View {
        self.modifier(DeleteSwiper(delete: deleteAction))
    }
}
