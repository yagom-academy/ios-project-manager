//
//  ToDoList.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct ToDoList: View {
    var body: some View {
        List {
            Text("TODO")
                .font(.largeTitle)
            
            ForEach(dummyToDos) { toDo in
                ToDoRow(toDo: toDo)
            }
        }
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList()
    }
}
