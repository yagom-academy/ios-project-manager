//
//  CustomAlert.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/21.
//

import SwiftUI

struct CustomAlert<Alert: View>: ViewModifier {
    @Binding var isOn: Bool
    let alert: Alert
    func body(content: Content) -> some View {
        ZStack {
            content
            if isOn {
                alert
            }
        }
    }
}

extension View {
    func customAlert<Alert: View>(
        isOn: Binding<Bool>,
        alertView: @escaping () -> Alert
    ) -> some View {
        modifier(CustomAlert(isOn: isOn, alert: alertView()))
    }
}
