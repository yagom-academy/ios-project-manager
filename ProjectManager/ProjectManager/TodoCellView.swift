//
//  TodoCellView.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct TodoCellView: View {
    var memo: Memo
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
        }
    }
}

let testData = [
    Memo(title: "title1", description: "descriptionsadfadsfdsafasdfdasfdsfasdfdsfasdfsadfdsfsadfdsafsdfsdf", date: Date(), state: .todo),
    Memo(title: "title2", description: "descriptionsadfadsfdsafasdfdasfdsfasdfdfsgdfsg", date: Date(), state: .todo),
    Memo(title: "titledescriptionsadfadsfdsafasdfdasfdsfasdfdsfasdfsadfdsfsadfdsafsdfsdf", description: "descriptionsadfadsfdsafasdfdasfdsfasdfdsfasdfsadfdsfsadfdsafsdfsdfdescriptionsadfadsfdsafasdfdasfdsfasdfdsfasdfsadfdsfsadfdsafsdfsdf", date: Date(), state: .todo)
]

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCellView(memo: testData[0])
    }
}
