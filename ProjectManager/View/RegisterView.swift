//
//  RegisterView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/14.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var registerViewModel: RegisterViewModel
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
        let max = Calendar.current.date(byAdding: .year, value: 1, to: Date().addingTimeInterval(60*60*24*365)) ?? Date()
        
        return min...max
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $registerViewModel.title)
                    .foregroundColor(Color.gray)
                    .padding(.all)
                    .border(Color(UIColor.separator))
                    .padding(.leading)
                    .padding(.trailing)
                    .font(.title2)
                
                DatePicker("",
                           selection: $registerViewModel.date,
                           in: dateRange,
                           displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                TextEditor(text: $registerViewModel.body)
                    .foregroundColor(Color.gray)
                    .lineSpacing(5)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: 200)
                    .padding(.all)
                    .border(Color(UIColor.separator), width: 1)
                    .padding(.leading)
                    .padding(.trailing)
            }.onDisappear {
                registerViewModel.title = ""
                registerViewModel.date = Date()
                registerViewModel.body = ""
            }
                .navigationTitle(TaskType.todo.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(.systemGray5)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            registerViewModel.doneButtonTapped()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(registerViewModel: RegisterViewModel(withService: TaskManagementService()))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
