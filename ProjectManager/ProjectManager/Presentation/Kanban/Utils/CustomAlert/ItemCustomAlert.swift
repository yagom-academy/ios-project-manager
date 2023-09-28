//
//  ItemCustomAlert.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/29.
//

import SwiftUI

struct ItemCustomAlert<Alert: View, T>: ViewModifier {
    @Binding var item: T?
    let alertView: Alert
    func body(content: Content) -> some View {
        ZStack {
            content
            if item != nil {
                bluredBackground
                alertView
            }
        }
    }
    
    var bluredBackground: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                item = nil
            }
    }
}

extension View {
    func customAlert<Alert: View, T>(
        item: Binding<T?>,
        alertView: @escaping () -> Alert
    ) -> some View {
        modifier(
            ItemCustomAlert(
                item: item,
                alertView: alertView()
            )
        )
    }
}

