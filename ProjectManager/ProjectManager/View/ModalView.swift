//
//  ModalView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/18.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject private var viewModel: ProjectViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var project: Project
    @State var disableEdit: Bool
    let isEditMode: Bool
    
    var body: some View {
        NavigationStack {
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
                        isEditMode ? viewModel.update(project: project) : viewModel.create(project: project)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isEditMode ? disableEdit.toggle() : presentationMode.wrappedValue.dismiss()
                    } label: {
                        isEditMode ? Text("Edit") : Text("Cancel")
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
            isEditMode: true
        )
        .environmentObject(ProjectViewModel())
    }
}
