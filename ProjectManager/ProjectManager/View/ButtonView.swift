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
            print("NewEvent")
        }.sheet(isPresented: $isButtonTabbed, onDismiss: {
            
        }, content: {
            DetailEventView().environmentObject(viewModel)
        })
    }
}

struct DoneEventButton: View {
    @EnvironmentObject var viewModel: ProjectLists
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Button("Done", role: .none) {
                self.viewModel.create()
                self.presentationMode.wrappedValue.dismiss()
            }
        } else {
            
        }
    }
}
