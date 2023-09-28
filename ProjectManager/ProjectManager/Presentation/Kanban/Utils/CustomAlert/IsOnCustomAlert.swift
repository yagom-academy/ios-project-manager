//
//  IsOnCustomAlert.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/29.
//

import SwiftUI

struct IsOnCustomAlert<Alert: View>: ViewModifier {
    @Binding var isOn: Bool
    let alertView: Alert
    func body(content: Content) -> some View {
        ZStack {
            content
            if isOn {
                bluredBackground
                alertView
            }
        }
    }
    
    var bluredBackground: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                isOn = false
            }
    }
}

extension View {
    func customAlert<Alert: View>(
        isOn: Binding<Bool>,
        alertView: @escaping () -> Alert
    ) -> some View {
        modifier(
            IsOnCustomAlert(
                isOn: isOn,
                alertView: alertView()
            )
        )
    }
}
