//
//  ButtonView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/01.
//

import SwiftUI

struct AddEventButton: View {
    @State private var isButtonTabbed: Bool = false
    @EnvironmentObject var viewModel: ProjectLists

    var body: some View {
        Button("+") {
            isButtonTabbed.toggle()
            self.viewModel.create()
        }.sheet(isPresented: $isButtonTabbed,
                onDismiss: {
            
        }, content: {
            DetailEventView(id: UUID())
                .environmentObject(viewModel)
        })
    }
}

