//
//  TodoListRow.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct TodoListRow: View {
    var todoListItem: TodoListItem
    @EnvironmentObject var viewModel: TodoListViewModel
    let formatter = dateFormatter()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(todoListItem.title)
            Text(todoListItem.description)
            Text("\(formatter.format(date: todoListItem.date))")
        }.foregroundColor(.teal)
    }
    //        .onTapGesture {
    //            isPresented = true
    //            popover(isPresented: $isPresented) {
    ////                isPresented = false
    //                Text("a")
    //            }
}

class dateFormatter {
    func format(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
