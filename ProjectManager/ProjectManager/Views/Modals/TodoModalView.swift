//
//  ModalView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/03.
//

import SwiftUI

struct TodoModalView: View {
    enum TodoModalType {
        case new
        case detail
        case edit
    }
    
    @State private var title: String
    @State private var dueDate: Date
    @State private var description: String
    @Binding private var showModal: Bool
    @State private var modalType: TodoModalType
    
    init(showModal: Binding<Bool>) {
        _title = State(initialValue: "")
        _dueDate = State(initialValue: Date())
        _description = State(initialValue: "")
        _modalType = State(initialValue: .detail)
        _showModal = showModal
    }
    
    init(todoVM: TodoViewModel, showModal: Binding<Bool>) {
        _title = State(initialValue: todoVM.title)
        _dueDate = State(initialValue: todoVM.dueDate)
        _description = State(initialValue: todoVM.description)
        _modalType = State(initialValue: .detail)
        _showModal = showModal
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .font(.title2)
                    .textFieldStyle(TodoTextFieldStyle())
                    
                
                DatePicker(selection: $dueDate,
                           displayedComponents: [.date, .hourAndMinute],
                           label: {
                            Text("Select Date")
                           })
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding([.leading, .trailing])
                
                TextEditor(text: $description)
                    .padding()
                    .font(.title3)
                    .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
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
        switch modalType {
        case .new, .edit:
            return AnyView(cancelButton)
        case .detail:
            return AnyView(editButton)
        }
    }
    
    var trailingButton: some View {
        switch modalType {
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
            self.modalType = .edit
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
