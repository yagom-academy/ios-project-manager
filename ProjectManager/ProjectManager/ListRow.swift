//
//  ListRow.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import SwiftUI

struct ListRow: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    @State var isShowPopover: Bool = false
    
    @State private var isShowModal: Bool = false
    
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.title3)
                Text(task.description)
                    .lineLimit(3)
                    .foregroundColor(.gray)
                if task.date <= Date() {
                    Text(task.localizedDate)
                        .foregroundColor(.red)
                } else {
                    Text(task.localizedDate)
                }
            }
            Spacer()
        }
        .onTapGesture {
            self.isShowModal = true
        }
        .sheet(isPresented: self.$isShowModal, content: {
            ModalView(modalState: .inquire, task: task)
        })
        .onLongPressGesture {
            self.isShowPopover = true
        }
        .popover(isPresented: $isShowPopover, content: {
            switch task.state {
            case .todo:
                VStack {
                    moveToDoingButton
                    moveToDoneButton
                }
            case .doing:
                VStack {
                    moveToTodoButton
                    moveToDoneButton
                }
            case .done:
                VStack {
                    moveToTodoButton
                    moveToDoingButton
                }
            }
        })
        .padding()
        .background(Color.white)
    }
}

extension ListRow {
    
    private var moveToTodoButton: some View {
        Button(action: {
            taskViewModel.updateTask(id: task.id, state: .todo)
        }) {
            Text("Move to TODO")
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
    
    private var moveToDoingButton: some View {
        Button(action: {
            taskViewModel.updateTask(id: task.id, state: .doing)
        }) {
            Text("Move to DOING")
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
    
    private var moveToDoneButton: some View {
        Button(action: {
            taskViewModel.updateTask(id: task.id, state: .done)
        }) {
            Text("Move to DONE")
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(task: TaskViewModel().tasks[0])
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
