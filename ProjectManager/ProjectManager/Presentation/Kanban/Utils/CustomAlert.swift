//
//  CustomAlert.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/21.
//

import SwiftUI

struct CustomAlert<Alert: View>: ViewModifier {
    @Binding var isOn: Bool
    let title: String
    let alertView: Alert
    func body(content: Content) -> some View {
        GeometryReader { geo in
            let width = geo.size.width * (1 / 2)
            let height = width * (6 / 5)
            ZStack {
                content
                if isOn {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isOn = false
                        }
                    NavigationStack {
                        alertView
                            .navigationTitle(title)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .cornerRadius(10)
                    .frame(width: width, height: height)
                }
            }
        }
    }
}

extension View {
    func customAlert<Alert: View>(
        isOn: Binding<Bool>,
        title: String,
        alertView: @escaping () -> Alert
    ) -> some View {
        modifier(
            CustomAlert(
                isOn: isOn,
                title: title,
                alertView: alertView()
            )
        )
    }
}
