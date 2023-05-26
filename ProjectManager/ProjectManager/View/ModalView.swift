//
//  ModalView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/18.
//

import SwiftUI

struct ModalView: View {
    @State var project: Project
    let dateFormatter = ProjectDateFormatter.shared
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Enter your Title", text: $project.title)
                    .padding(14)
                    .border(Color(UIColor.systemGray5))
                
                DatePicker("Date", selection: $project.date, displayedComponents: .date)
                                   .datePickerStyle(.wheel)
                                   .labelsHidden()
                    
                
                TextEditor(text: $project.body)
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
        ModalView(project: .init(title: "", body: "", date: Date()))
    }
}
