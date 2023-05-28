//
//  ModalView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/18.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State var project: Project
    @State var disableEdit: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isEdit: Bool
    
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
            .disabled(disableEdit)
            .padding(.init(top: 5, leading: 10, bottom: 20, trailing: 10))
            .navigationTitle(project.state.rawValue.uppercased())
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdit ? viewModel.update(project: project) : viewModel.create(project: project)
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isEdit ? disableEdit.toggle() : presentationMode.wrappedValue.dismiss()
                    } label: {
                        isEdit ? Text("Edit") : Text("Cancel")
                    }
                }
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(
            project: .init(title: "", body: "", date: Date()),
            disableEdit: true,
            isEdit: true
        )
        .environmentObject(ProjectViewModel())
    }
}
