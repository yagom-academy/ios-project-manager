//
//  TodoListAddView.swift
//  ProjectManager
//
//  Created by 재재, 언체인  on 2022/09/12.
//

import SwiftUI

struct TodoListAddView: View {
    var body: some View {
        VStack {
            TodoListAddTitleView()
            TitleTextView()
            DatePickerView()
        }
    }
}

struct TodoListAddTitleView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
                    .font(.title3)
            })
            .padding(10)
            Spacer()
            Text("Project Manager")
                .font(.title)
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Text("Done")
                    .font(.title3)
                    .padding(10)
            })
        }
    }
}

struct TitleTextView: View {
    @State var title: String = ""

    var body: some View {
        TextField("Title", text: $title)
            .padding()
            .background(Color(.systemBackground))
            .shadow(color: .gray, radius: 5, x: 10, y: 10)
            .padding(12)
    }
}

struct DatePickerView: View {
    @State var date = Date()

    var body: some View {
        DatePicker("",
                   selection: $date,
                   displayedComponents: .date)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
    }
}

struct TodoListAddView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListAddView()
    }
}
