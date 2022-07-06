//
//  RegisterElementsView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct RegisterElementsView: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var text: String = ""
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: date) ?? Date()
        let max = Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
        
        return min...max
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .foregroundColor(Color.gray)
                .padding(.all)
                .border(Color(UIColor.separator))
                .padding(.leading)
                .padding(.trailing)
                .font(.title2)
                
            DatePicker("",
                       selection: $date,
                       in: dateRange,
                       displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            TextEditor(text: $text)
                .foregroundColor(Color.gray)
                .lineSpacing(5)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: 200)
                .border(Color.yellow, width: 1)
        }
    }
}

struct RegisterElementsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterElementsView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
