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
                    ForEach(viewModel.doingList) { model in
                        ProjectListCell(model: model)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(cases: .todo, at: indexSet)
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
                case .doing:
                    ForEach(viewModel.doingList) { model in
                        ProjectListCell(model: model)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(cases: .doing, at: indexSet)
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
                case .done:
                    ForEach(viewModel.doingList) { model in
                        ProjectListCell(model: model)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(cases: .done, at: indexSet)
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
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
}

struct ProjectListView_Previews: PreviewProvider {

    static var previews: some View {
        ProjectListView(viewModel: ProjectViewModel(), formCase: .doing)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
