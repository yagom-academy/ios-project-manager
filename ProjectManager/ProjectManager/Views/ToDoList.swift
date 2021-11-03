//
//  ToDoList.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct ToDoList: View {
    @Binding var isDetailViewPresented: Bool
    
    var body: some View {
        List {
            ToDoHeader(headerTitle: "TODO", rowCount: "12")
            
            ForEach(dummyToDos) { toDo in
                ToDoRow(toDo: toDo)
                    .onTapGesture {
                        isDetailViewPresented = true
                    }
            }
        }
        .listStyle(.plain)
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList(isDetailViewPresented: .constant(false))
    }
}
