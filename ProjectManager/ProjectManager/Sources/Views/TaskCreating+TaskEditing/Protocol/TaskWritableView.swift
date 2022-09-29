//
//  TaskWritableView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/28.
//

import SwiftUI

protocol TaskWritableView { }

extension TaskWritableView {
    func datePickerView(withSelection date: Binding<Date>) -> some View {
        HStack() {
            Image(systemName: "calendar")

            DatePicker("", selection: date, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ko"))
                .labelsHidden()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal)
        .padding(.bottom, 1)
    }
    
    func taskWritingViews(title: Binding<String>, description: Binding<String>) -> some View {
        Group {
            TextField("할 일의 제목을 입력해주세요", text: title)
                .frame(height: 55)
                .padding(.horizontal, 4)
            
            TaskDescriptionView(description: description)
                .frame(maxHeight: 500)
                .padding(.top, 10)
                .overlay(alignment: .topLeading) {
                    if description.wrappedValue.isEmpty {
                        Text("필요한 경우 상세설명을 적어주세요")
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.top, 20)
                    }
                }
        }
        .padding(.horizontal)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
