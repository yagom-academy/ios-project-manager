//
//  MemoView.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/01.
//

import SwiftUI

struct MemoView: View {
    @ObservedObject var viewModel: MemoViewModel
    @Binding var isEdited: Bool

    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()

    var body: some View {
        UINavigationBar.appearance().backgroundColor = UIColor(cgColor: Color.basic.cgColor!)

        return NavigationView {
            VStack(
                alignment: .center,
                spacing: UIStyle.minInsetAmount
            ) {
                TextField(
                    "Title",
                    text: $title
                )
                    .padding()
                    .border(.red)

                DatePicker(
                    "Start date",
                    selection: $date,
                    displayedComponents: .date
                )
                    .labelsHidden()
                    .datePickerStyle(.wheel)

                TextEditor(text: $description)
                    .padding()
                    .border(.red)
            }
            .padding()
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarLeading
                ) {
                    Button {
                        isEdited = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing
                ) {
                    Button {
                        print("DONE")
                    } label: {
                        Text("DONE")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(
            viewModel: MemoViewModel(),
            isEdited: .constant(true)
        )
    }
}
