//
//  TodoCellView.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct TodoCellView: View {
    var memo: Memo
    var todoViewModel: TodoViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.title)
                .font(.title)
                .bold()
                .lineLimit(1)
            Text(memo.description)
                .font(.body)
                .foregroundColor(Color.gray)
                .lineLimit(3)
            Text("\(memo.date.formatDate())")
                .font(.caption)
                .foregroundColor(todoViewModel.changeDateColor(date: memo.date, state: memo.state))
        }
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoCellView(memo: Memo(title: "title", description: "des", date: Date(), state: .todo), todoViewModel: todoViewModel)
//    }
//}
