//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
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
                HStack {
                    Text(currentState.rawValue)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 25)
                        Text(String(viewModel.selectList(cases: currentState).count))
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .listStyle(.grouped)
    }
 
}

private extension ProjectListView {
    func createListItems(for models: [Project], onDelete: @escaping (IndexSet) -> Void) -> some View {
        ForEach(Array(models.enumerated()), id: \.offset) { index, model in
            ProjectListCell(model: model, state: currentState)
                .contextMenu {
                    Button(currentState.popoverItem.0.popoverText) {
                        viewModel.move(index: index, state: currentState, to: currentState.popoverItem.0)
                    }
                    Button(currentState.popoverItem.1.popoverText) {
                        viewModel.move(index: index, state: currentState, to: currentState.popoverItem.1)
                    }
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
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(currentState: .doing)
            .environmentObject(ProjectViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
