//
//  CustomAlert.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/03.
//

import SwiftUI

struct CustomAlert<Alert: View, T>: ViewModifier {
    @EnvironmentObject var keyboardManager: KeyboardManager
    @Binding var item: T?
    @Binding var isOn: Bool
    let alertView: Alert
    
    init(
        item: Binding<T?> = .constant(nil),
        isOn: Binding<Bool> = .constant(false),
        alertView: Alert
    ) {
        self._item = item
        self._isOn = isOn
        self.alertView = alertView
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isOn || item != nil {
                bluredBackground
                alertView
            }
        }
    }
    
    var bluredBackground: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                if keyboardManager.isVisible {
                    keyboardManager.hide()
                } else {
                    isOn = false
                    item = nil
                }
            }
    }
}

extension View {
    func customAlert<Alert: View, T>(
        item: Binding<T?>,
        alertView: @escaping () -> Alert
    ) -> some View {
        modifier(
            CustomAlert(
                item: item,
                alertView: alertView()
            )
        )
    }
}

extension View {
    func customAlert<Alert: View>(
        isOn: Binding<Bool>,
        alertView: @escaping () -> Alert
    ) -> some View {
        modifier(
            CustomAlert<Alert, Any>(
                isOn: isOn,
                alertView: alertView()
            )
        )
    }
}

