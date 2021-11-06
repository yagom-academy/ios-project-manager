//
//  MemoView.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/01.
//

import SwiftUI

struct MemoView: View {
    @ObservedObject var viewModel: MemoViewModel
    @Binding var isShow: Bool

    @State private var blockToUpdate = false
    @State private var title = ""
    @State private var description = "입력가능한 숫자는 1000글자로 제한합니다"
    @State private var date = Date()

    private var eachComponentOpacity: CGFloat {
        blockToUpdate ? 0.7 : 1
    }

    var body: some View {
        UINavigationBar.appearance().backgroundColor = UIColor(cgColor: Color.basic.cgColor!)

        return NavigationView {
            VStack(
                alignment: .center,
                spacing: UIStyle.minInsetAmount
            ) {
                titleView
                datePicker
                descriptionView
            }
            .opacity(eachComponentOpacity)
            .disabled(blockToUpdate)
            .padding()
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    if blockToUpdate {
                        editButton
                    } else {
                        doneButton
                    }
                }
            }
            .onAppear {
                if let memo = viewModel.memoToEdit {
                    title = memo.title
                    description = memo.body
                    date = memo.date

                    blockToUpdate = true
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - View components
extension MemoView {
    private var titleView: some View {
        TextField("Title", text: $title)
            .padding()
            .border(.gray)
            .background(
                Rectangle()
                    .fill(.white)
                    .shadow(radius: UIStyle.shadowAmount)
            )
    }

    private var datePicker: some View {
        DatePicker(
            "Start date",
            selection: $date,
            displayedComponents: .date
        )
            .labelsHidden()
            .datePickerStyle(.wheel)
    }

    private var descriptionView: some View {
        TextEditor(text: $description)
            .padding()
            .border(.gray)
            .background(
                Rectangle()
                    .fill(.white)
                    .shadow(radius: UIStyle.shadowAmount)
            )
            .onTapGesture {
                let placeholder = "입력가능한 숫자는 1000글자로 제한합니다"
                if description == placeholder {
                    description = ""
                }
            }
    }

    private var cancelButton: some View {
        Button {
            isShow = false
        } label: {
            Text("Cancel")
        }
    }

    private var editButton: some View {
        Button {
            blockToUpdate = false
        } label: {
            Text("Edit")
        }
    }

    private var doneButton: some View {
        Button {
            let memo = Memo(
                id: UUID(),
                title: title,
                body: description,
                date: date,
                state: .todo
            )

            viewModel.edit(memo)
            isShow = false
        } label: {
            Text("DONE")
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView.init(
            viewModel: MemoViewModel(),
            isShow: .constant(true)
        )
    }
}
