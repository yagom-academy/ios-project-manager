//
//  TodoRow.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoRow: View {
    var todo: Todo
    
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
            let todayDate: TimeInterval = Date().timeIntervalSince1970
            let checkDeadline: Bool = todo.completionState != .done && todayDate > todo.endDate
            Text(todo.endDate.dateFormatString())
                .font(.footnote)
                .foregroundColor(checkDeadline ? .red : .black)
        }
        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoRow(todo: Todo(
            id: 1,
            title: "테스트 제목",
            detail: "테스트 본문",
            endDate: Date().timeIntervalSince1970,
            completionState: .done))
    }
}
