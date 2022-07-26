//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .foregroundColor(.black)
            Text(task.body)
                .foregroundColor(.gray)
            checkOverdate()
        }
    }
    
    func checkOverdate() -> some View {
        if task.isOverdate {
            return Text(task.date.convertDateToString)
                .foregroundColor(.red)
        } else {
            return Text(task.date.convertDateToString)
                .foregroundColor(.black)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(task: Task(title: "Title", date: Date(), body: "body", type: .todo))
            .previewLayout(.sizeThatFits)
    }
}
