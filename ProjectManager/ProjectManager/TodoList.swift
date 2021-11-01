//
//  TodoList.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct TodoList: View {
    var body: some View {
        List {
            Section(header: ToDoListHeaderView()) {
                ForEach(testData) { data in
                    TodoCellView(memo: data)
                }
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
