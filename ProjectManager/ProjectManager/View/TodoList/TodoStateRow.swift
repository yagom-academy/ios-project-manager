//
//  TodoStateRow.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoStateRow: View {
    @EnvironmentObject private var viewModel: TodoViewModel
    @State private var isShowingModalView: Bool = false
    @State private var isShowingActionSheet: Bool = false
    var todo: Todo
    private var isAfterDeadline: Bool {
        return todo.state != TodoList.State.done && todo.endDate.isAfterDue
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(todo.title)
                .font(.title3)
                .lineLimit(1)
            Text(todo.detail)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 1.0)
                .lineLimit(3)
            Text(todo.endDate.formattedString)
                .font(.footnote)
                .foregroundColor(isAfterDeadline ? .red : .black)
        }
        .truncationMode(.tail)
        .onTapGesture { isShowingModalView.toggle() }
        .sheet(isPresented: $isShowingModalView) {
            TodoModalView(isPresented: $isShowingModalView, viewPurpose: .show, todo: todo)
                .environmentObject(viewModel)
        }
        .onLongPressGesture { isShowingActionSheet.toggle() }
        .actionSheet(isPresented: $isShowingActionSheet) {
            ActionSheet(title: Text("Todo의 상태를 변경하세요"), buttons: makeStateChangeActionSheet())
        }
    }
}

extension TodoStateRow {
    private func makeStateChangeActionSheet() -> [ActionSheet.Button] {
        let selections: [TodoList.State] = TodoList.State.allCases.filter { state in
            return state != todo.state
        }
        let buttons: [ActionSheet.Button] = selections.map { state in
            return ActionSheet.Button.default(Text("Movo to \(state.description)")) {
                viewModel.changeTodoState(todo, to: state)
            }
        }
        return buttons
    }
}

struct TodoStateRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoStateRow(todo: Todo(
            title: "테스트 제목",
            detail: "테스트 본문",
            endDate: Date(),
            state: .done))
            .previewLayout(.sizeThatFits)
    }
}
