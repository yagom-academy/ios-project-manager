//
//  TodoRowView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct TodoRowView: View {
    var todo: Todo

    var body: some View {
        VStack(alignment: .leading) {
            Text(todo.title)
                .font(.title3)
            Text(todo.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
//            Text(String(todo.date))
//                .font(.footnote)
        }.lineLimit(1)
    }
}


struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(todo: Todo(title: "할일",
                                           description: "오늘은 설거지를 할게여",
                                           date: Date(), type: .toDo))
//            .previewLayout(.sizeThatFits)
    }
}
