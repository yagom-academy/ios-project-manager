//
//  EditElementView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct EditElementView: View {
    @State var task: Task
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
        let max = Calendar.current.date(byAdding: .year, value: 1, to: Date().addingTimeInterval(60*60*24*365)) ?? Date()
        
        return min...max
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $task.title)
                .foregroundColor(Color.gray)
                .padding(.all)
                .border(Color(UIColor.separator))
                .padding(.leading)
                .padding(.trailing)
                .font(.title2)
            
            DatePicker("",
                       selection: $task.date,
                       in: dateRange,
                       displayedComponents: [.date])
            .datePickerStyle(.wheel)
            .labelsHidden()
            
            TextEditor(text: $task.body)
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
        }
    }
}

struct RegisterElementsView_Previews: PreviewProvider {
    static var previews: some View {
        EditElementView(task: Task(title: "title", date: Date(), body: "body", type: .todo))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
