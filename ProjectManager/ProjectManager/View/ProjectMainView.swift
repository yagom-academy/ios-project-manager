//
//  ProjectMainView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/16.
//

import SwiftUI

struct ProjectMainView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var showModal = false
    
    var body: some View {
        NavigationStack{
            HStack{
                ProjectListView(currentState: .todo)
                    .environmentObject(viewModel)
                ProjectListView(currentState: .doing)
                    .environmentObject(viewModel)
                ProjectListView(currentState: .done)
                    .environmentObject(viewModel)
            }
            .background(Color(UIColor.systemGray4))
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $showModal) {
                
                ModalView(project: Project(title: "", body: "", date: Date()), disableEdit: false, state: .todo, isEdit: false)
            }
        }
    }
}

struct ProjectMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectMainView()
            .environmentObject(ProjectViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
