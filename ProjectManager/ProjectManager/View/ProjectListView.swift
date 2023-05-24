//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    @ObservedObject var viewModel: ProjectViewModel
    let formCase: ProjectState
    
    var body: some View {
        List {
            Section {
                createListItems(for: viewModel.selectList(cases: formCase)) { indexSet in
                    viewModel.delete(cases: formCase, at: indexSet)
                }
            } header: {
                HStack {
                    Text(formCase.rawValue)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 25)
                        Text(String(viewModel.selectList(cases: formCase).count))
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
