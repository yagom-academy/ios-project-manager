//
//  ProjectListCell.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListCell: View {
    let viewModel: ProjectViewModel
    let model: Project
    let state: ProjectState
    @State private var isShowingPopOver = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(model.date)
        }.contextMenu {
            createPopoverItem(items: state.popoverItem)
        }

    }
    
    func createPopoverItem(items: (first: ProjectState, second: ProjectState)) -> some View {
        VStack{
            Button(items.first.popoverText) {
                viewModel.move(model: model, from: state, to: items.first)
            } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            
            Button(items.second.popoverText) {
                viewModel.move(model: model, from: state, to: items.second)
            } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
        }
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {

        ProjectListCell(
            viewModel: ProjectViewModel(),
            model: Project(title: "안녕", body: "하세요", date: "2022.12.03"),
            state: .doing)
    }
}
