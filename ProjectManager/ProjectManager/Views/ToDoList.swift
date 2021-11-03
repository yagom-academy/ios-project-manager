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
        VStack(alignment: .leading, spacing: 3) {
            ToDoHeader(headerTitle: "TODO", rowCount: "12")
            
            List {
                ForEach(dummyToDos) { toDo in
                    ToDoRow(toDo: toDo)
                        .onTapGesture {
                            isDetailViewPresented = true
                        }
                }
                .onDelete { indexSet in
                    
                }
            }
            .listStyle(.plain)
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList(isDetailViewPresented: .constant(false))
    }
}
