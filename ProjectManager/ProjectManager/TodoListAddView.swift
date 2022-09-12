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
            TodoListAddTitleTextView()
            TodoListAddDatePickerView()
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

struct TodoListAddTitleTextView: View {
    @State var title: String = ""

    var body: some View {
        TextField("Title", text: $title)
            .padding()
            .background(Color(.systemBackground))
            .shadow(color: .gray, radius: 5, x: 10, y: 10)
            .padding(12)
    }
}

struct TodoListAddDatePickerView: View {
    @State var date = Date()

    var body: some View {
        DatePicker("",
                   selection: $date,
                   displayedComponents: .date)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
    }
}

struct DetailTextView: View {
    @State var textString: String = ""
    @State var placeHolder: String = "내용을 입력하세요(글자수는 1000자로 제한합니다"

    var body: some View {

        ZStack {
            if self.textString.isEmpty {
                TextEditor(text: $placeHolder)
                    .font(.body)
                    .disabled(true)
                    .padding()
            }
            TextEditor(text: $textString)
                .font(.body)
                .opacity(self.textString.isEmpty ? 0.25 : 1)
                .padding()
                .disableAutocorrection(true)
        }
    }
}

struct TodoListAddView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListAddView()
    }
}
