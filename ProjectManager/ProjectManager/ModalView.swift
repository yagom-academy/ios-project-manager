//
//  ModalView.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/11/02.
//

import SwiftUI

struct ModalView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "Title",
                    text: $title
                )
                .frame(height: 44)
                .background(Color.white)
                .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                .padding(.horizontal)
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                TextField(
                    "Description",
                    text: $description
                )
                .frame(height: 300, alignment: .top)
                .background(Color.white)
                .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                .padding(.horizontal)
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done"){
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
