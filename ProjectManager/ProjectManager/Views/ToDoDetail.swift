//
//  ToDoDetail.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct ToDoDetail: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var description = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("Edit")
                }
                Spacer()
                Text("TODO")
                Spacer()
                Button {
                    
                } label: {
                    Text("Done")
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            VStack {
                TextField("Title", text: $title)
                    .padding()
                    .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                DatePicker(selection: $date, label: {})
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                TextEditor(text: $description)
                    .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
            }
            .padding()
        }
    }
}

struct ToDoDetail_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetail()
    }
}
