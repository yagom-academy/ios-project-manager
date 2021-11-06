//
//  ModalView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/03.
//

import SwiftUI

struct TodoModalView: View {
    @ObservedObject var todoModalVM: TodoModalViewModel
    @Binding private var showModal: Bool
    
    init(showModal: Binding<Bool>) {
        _showModal = showModal
        self.todoModalVM = TodoModalViewModel()
    }
    
    init(todoVM: TodoViewModel, showModal: Binding<Bool>) {
        _showModal = showModal
        self.todoModalVM = TodoModalViewModel(todoVM)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $todoModalVM.title)
                    .font(.title2)
                    .textFieldStyle(TodoTextFieldStyle())
                    .disabled(todoModalVM.isDisabled)
                    
                
                DatePicker(selection: $todoModalVM.dueDate,
                           displayedComponents: [.date, .hourAndMinute],
                           label: {
                            Text("Select Date")
                           })
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding([.leading, .trailing])
                    .disabled(todoModalVM.isDisabled)
                
                TextEditor(text: $todoModalVM.description)
                    .padding()
                    .font(.title3)
                    .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .disabled(todoModalVM.isDisabled)
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
        switch todoModalVM.modalType {
        case .new, .edit:
            return AnyView(cancelButton)
        case .detail:
            return AnyView(editButton)
        }
    }
    
    var trailingButton: some View {
        switch todoModalVM.modalType {
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
            todoModalVM.updateModalType(modalType: .edit)
        }
    }
    
    var newDoneButton: some View {
        Button("Done") {
            self.showModal = false
        }
    }
    
    var editDoneButton: some View {
        Button("Done") {
            self.showModal = false
        }
    }
    
    var detailDoneButton: some View {
        Button("Done") {
            self.showModal = false
        }
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
