//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    let viewModel: ProjectViewModel
    let currentState: ProjectState
    
    var body: some View {
    
        List {
            Section {
                switch currentState {
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
                Text(currentState.rawValue)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.light)
            }
        }
        
        .listStyle(.grouped)
    }
    
    func createListItems(for models: [Project], onDelete: @escaping (IndexSet) -> Void) -> some View {
        ForEach(models) { model in
            ProjectListCell(viewModel: viewModel, model: model, state: currentState)
                .contextMenu {
                    createPopoverItem(items: currentState.popoverItem)
                }
        }
        .onDelete(perform: onDelete)
        .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
        .listRowBackground(
            Rectangle()
                .fill(.white)
                .padding(.top, 10)
        )
    }
    
    func createPopoverItem(items: (first: ProjectState, second: ProjectState)) -> some View {
        VStack{
            Button(items.first.popoverText) {
                
            } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            
            Button(items.second.popoverText) {
                
            } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
        }
    }
}

struct ProjectListView_Previews: PreviewProvider {

    static var previews: some View {
        ProjectListView(viewModel: ProjectViewModel(), currentState: .doing)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
