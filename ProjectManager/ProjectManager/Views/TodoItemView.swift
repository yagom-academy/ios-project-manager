//
//  TodoItemRow.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/01.
//

import SwiftUI

struct TodoItemView: View {
    @EnvironmentObject var todoListVM: TodoListViewModel
    @State private var showModal = false
    @State private var showPopover = false
    let todo: TodoViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title)
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(.primary)
            
                Text(todo.description)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 3, trailing: 0))
                
                Text(todo.dueDateFormatted)
                    .foregroundColor(todo.isExpired ? .red : .black)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .onTapGesture() {
            self.showModal = true
        }
        .sheet(isPresented: $showModal, content: {
            TodoModalView(todoVM: todo, showModal: $showModal)
        })
        .onLongPressGesture {
            self.showPopover = true
        }
        .popover(isPresented: $showPopover) {
            popoverView
        }
        
    }
}

extension TodoItemView {
    var topButtonText: String {
        switch todo.status {
        case .todo: return "Move to DOING"
        case .doing, .done: return "Move to TODO"
        }
    }
    
    var bottomButtonText: String {
        switch todo.status {
        case .todo, .doing: return "Move to DONE"
        case .done: return "Move to DOING"
        }
    }
    
    var popoverView: some View {
        VStack {
            Button(topButtonText) {
                moveToItemOnTopButton()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.white)
            .padding([.bottom], 5)
            
            Button(bottomButtonText) {
                moveToItemOnBottomButton()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.white)
        }
        .padding()
        .background(Color.init(UIColor(red: 239/256,
                                       green: 239/256,
                                       blue: 239/256,
                                       alpha: 1)))
    }
    
    func moveToItemOnTopButton() {
        switch todo.status {
        case .todo: self.todoListVM.updateStatus(of: todo, to: .doing)
        case .doing, .done: self.todoListVM.updateStatus(of: todo, to: .todo)
        }
    }
    
    func moveToItemOnBottomButton() {
        switch todo.status {
        case .todo, .doing: self.todoListVM.updateStatus(of: todo, to: .done)
        case .done: self.todoListVM.updateStatus(of: todo, to: .doing)
        }
    }
}

struct TodoItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todo: TodoViewModel.init(todo: Todo(title: "책상정리",
                                                         description: "집중이 안될 땐 역시나 책상정리",
                                                         dueDate: Date(year: 2021, month: 12, day: 5)!,
                                                         status: .todo)))
            .previewLayout(.fixed(width: 500, height: 300))
    }
}
