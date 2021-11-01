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
            Text(memo.description)
                .font(.body)
                .foregroundColor(Color.gray)
            Text("\(memo.date)")
                .font(.caption)
        }
    }
}

let testData = [
    Memo(title: "title1", description: "description", date: Date(), state: .todo),
    Memo(title: "title2", description: "description", date: Date(), state: .todo),
    Memo(title: "title", description: "description", date: Date(), state: .todo)
]

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCellView(memo: testData[0])
    }
}
