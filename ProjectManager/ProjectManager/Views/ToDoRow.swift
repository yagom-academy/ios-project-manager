//
//  ToDoRow.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct ToDoRow: View {
    let toDo: ToDo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDo.title)
                    .font(.title)
                Text(toDo.description)
                    .font(.body)
                    .foregroundColor(.gray)
                Text(toDo.date)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

struct ToDoRow_Previews: PreviewProvider {
    static var previews: some View {
        ToDoRow(toDo: dummyToDos[0])
    }
}
