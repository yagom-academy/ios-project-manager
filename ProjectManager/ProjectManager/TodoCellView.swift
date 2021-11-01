//
//  TodoCellView.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct TodoCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Test")
                .font(.title)
                .bold()
            Text("blablalbalbalbalblablabla")
                .font(.body)
                .foregroundColor(Color.gray)
            Text("2021-10-21")
                .font(.caption)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCellView()
    }
}
