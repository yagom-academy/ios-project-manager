//
//  ProjectMainView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/16.
//

import SwiftUI

struct ProjectMainView: View {
    @StateObject var viewModel = ProjectViewModel()
    @State private var showModal = false
    
    var body: some View {
        NavigationStack{
            HStack{
                ProjectListView(viewModel: viewModel, currentState: .todo)
                ProjectListView(viewModel: viewModel, currentState: .doing)
                ProjectListView(viewModel: viewModel, currentState: .done)
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
                ModalView()
            }
        }
    }
}

struct ProjectMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectMainView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
