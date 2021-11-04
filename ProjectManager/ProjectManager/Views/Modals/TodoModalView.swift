//
//  ModalView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/03.
//

import SwiftUI

struct TodoModalView: View {
    
    @State private var title: String
    @State private var dueDate: Date
    @State private var description: String
    @Binding private var showPopover: Bool
    
    init(title: String = "", dueDate: Date = Date(), description: String = "", showPopover: Binding<Bool>) {
        _title = State(initialValue: title)
        _dueDate = State(initialValue: dueDate)
        _description = State(initialValue: description)
        _showPopover = showPopover
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.showPopover = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showPopover = false
                    }, label: {
                        Text("Done")
                    })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
        TodoModalView(showPopover: .constant(true))
            .previewLayout(.fixed(width: 800, height: 600))
    }
}
