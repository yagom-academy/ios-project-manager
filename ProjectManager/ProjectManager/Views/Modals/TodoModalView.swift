//
//  ModalView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/03.
//

import SwiftUI

struct TodoModalView: View {
    @EnvironmentObject var todoListVM: TodoListViewModel
    @ObservedObject var todoFormVM: TodoFormViewModel
    @Binding private var showModal: Bool
    
    init(showModal: Binding<Bool>) {
        _showModal = showModal
        self.todoFormVM = TodoFormViewModel()
    }
    
    init(todoVM: TodoViewModel, showModal: Binding<Bool>) {
        _showModal = showModal
        self.todoFormVM = TodoFormViewModel(todoVM)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $todoFormVM.title)
                    .font(.title2)
                    .textFieldStyle(TodoTextFieldStyle())
                    .disabled(todoFormVM.isDisabled)
                    
                DatePicker(selection: $todoFormVM.dueDate,
                           displayedComponents: [.date, .hourAndMinute],
                           label: {
                            Text("Select Date")
                           })
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding([.leading, .trailing])
                    .disabled(todoFormVM.isDisabled)
                
                TextEditor(text: $todoFormVM.description)
                    .padding()
                    .font(.title3)
                    .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .disabled(todoFormVM.isDisabled)
            }
            .padding()
            .navigationBarTitle(Text("TODO"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: leadingButton,
                                trailing: trailingButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension TodoModalView {
    var leadingButton: some View {
        switch todoFormVM.modalType {
        case .new, .edit:
            return AnyView(cancelButton)
        case .detail:
            return AnyView(editButton)
        }
    }
    
    var trailingButton: some View {
        switch todoFormVM.modalType {
        case .new:
            return AnyView(newDoneButton)
        case .edit:
            return AnyView(editDoneButton)
        case .detail:
            return AnyView(detailDoneButton)
        }
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            self.showModal = false
        }
    }
    
    var editButton: some View {
        Button("Edit") {
            todoFormVM.updateModalType(modalType: .edit)
        }
    }
    
    var newDoneButton: some View {
        Button("Done", action: addTodo)
    }
    
    var editDoneButton: some View {
        Button("Done", action: updateTodo)
    }
    
    var detailDoneButton: some View {
        Button("Done") {
            self.showModal = false
        }
    }
}

extension TodoModalView {
    func addTodo() {
        self.todoListVM.addTodo(todoFormVM)
        self.showModal = false
    }
    
    func updateTodo() {
        self.todoListVM.updateTodo(todoFormVM)
        self.showModal = false
    }
}

struct TodoTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        TodoModalView(showModal: .constant(true))
            .previewLayout(.fixed(width: 800, height: 600))
    }
}
