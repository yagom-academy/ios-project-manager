//
//  CustomAlert.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/21.
//

import SwiftUI

struct CustomAlert<Alert: View>: ViewModifier {
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
            CustomAlert(
                isOn: isOn,
                alertView: alertView()
            )
        )
    }
}
