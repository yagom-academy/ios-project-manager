//
//  ModalView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/18.
//

import SwiftUI

struct ModalView: View {
    @State var title: String = ""
    @State var date: Date = .init()
    @State var text: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Enter your Title", text: $title)
                    .padding(14)
                    .border(Color(UIColor.systemGray5))
                
                DatePicker("ddd", selection: $date)
                    .datePickerStyle(.wheel).labelsHidden()
                
                TextEditor(text: $text)
                    .padding()
                    .font(.body)
                    .border(Color(UIColor.systemGray5))
            }
            .padding(.init(top: 5, leading: 10, bottom: 20, trailing: 10))
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
