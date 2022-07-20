//
//  RegisterElementView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/14.
//

import SwiftUI

struct RegisterElementView: View {
   @ObservedObject var taskViewModel: TaskViewModel
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
        let max = Calendar.current.date(byAdding: .year, value: 1, to: Date().addingTimeInterval(60*60*24*365)) ?? Date()
        
        return min...max
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $taskViewModel.title)
                .foregroundColor(Color.gray)
                .padding(.all)
                .border(Color(UIColor.separator))
                .padding(.leading)
                .padding(.trailing)
                .font(.title2)
                
            DatePicker("",
                       selection: $taskViewModel.date,
                       in: dateRange,
                       displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            TextEditor(text: $taskViewModel.body)
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
            taskViewModel.title = ""
            taskViewModel.date = Date()
            taskViewModel.body = ""
        }
    }
}

struct RegisterElementView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterElementView(taskViewModel: TaskViewModel())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
