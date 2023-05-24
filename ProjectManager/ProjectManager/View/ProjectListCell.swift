//
//  ProjectListCell.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListCell: View {
    //let model: Project
    let viewModel: ProjectViewModel
    let state: ProjectState
    let index: Int
    @State private var isShowingPopOver = false
    
    var body: some View {
        let model = viewModel.selectList(cases: state)[index]
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(model.date)
        }
        .onLongPressGesture(minimumDuration: 1.0) {
            isShowingPopOver = true
        }
        .popover(isPresented: $isShowingPopOver,
                 attachmentAnchor: .point(.bottom)
        ){
            switch state {
            case .todo:
                Button("Move to DOING") {
                    viewModel.move(index: index, state: state, to: .doing)
                } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
       
                Button("Move to DONE") {
                    viewModel.move(index: index, state: state, to: .done)
                } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            case .doing:
                Button("Move to TODO") {
                    viewModel.move(index: index, state: state, to: .todo)
                } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
       
                Button("Move to DONE") {
                    viewModel.move(index: index, state: state, to: .done)
                } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            case .done:
                Button("Move to TODO") {
                    viewModel.move(index: index, state: state, to: .todo)
                } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
       
                Button("Move to DOING") {
                    viewModel.move(index: index, state: state, to: .doing)
                } .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            }
            
        }
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {

        ProjectListCell(viewModel: ProjectViewModel(), state: .doing, index: 1)
    }
}
