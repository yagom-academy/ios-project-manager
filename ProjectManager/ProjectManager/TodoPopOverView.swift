//
//  TodoPopOverView.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/05.
//

import SwiftUI

struct TodoPopOverView: View {
    @State var memo: Memo
    @EnvironmentObject var todoList: TodoViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            ForEach(TodoState.allCases.filter({ $0 != memo.state
            }), id: \.self) { todoState in
                Button {
                    if let index = todoList.memoList.firstIndex(of: memo) {
                        todoList.memoList[index].state = todoState
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Move to \(todoState.description)")
                }
            }
        }
    }
}

struct TodoPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        TodoPopOverView(memo: Memo(title: "title", description: "des", date: Date(), state: .todo))
    }
}
