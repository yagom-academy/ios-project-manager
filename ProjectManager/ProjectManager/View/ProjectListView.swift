//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    let viewModel: ProjectViewModel
    let formCase: ProjectState
    
    var body: some View {
    
        List {
            Section {
                switch formCase {
                case .todo:
                    createListItems(for: viewModel.todoList, onDelete: { indexSet in
                        viewModel.delete(cases: .todo, at: indexSet)
                    })
                case .doing:
                    createListItems(for: viewModel.doingList, onDelete: { indexSet in
                        viewModel.delete(cases: .doing, at: indexSet)
                    })
                case .done:
                    createListItems(for: viewModel.doneList, onDelete: { indexSet in
                        viewModel.delete(cases: .done, at: indexSet)
                    })
                }
                
            } header: {
                Text(formCase.rawValue)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.light)
            }
        }
        
        .listStyle(.grouped)
    }
    
    func createListItems(for models: [Project], onDelete: @escaping (IndexSet) -> Void) -> some View {
        ForEach(models) { model in
            ProjectListCell(model: model)
        }
        .onDelete(perform: onDelete)
        .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
        .listRowBackground(
            Rectangle()
                .fill(.white)
                .padding(.top, 10)
        )
    }
}

struct ProjectListView_Previews: PreviewProvider {

    static var previews: some View {
        ProjectListView(viewModel: ProjectViewModel(), formCase: .doing)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
