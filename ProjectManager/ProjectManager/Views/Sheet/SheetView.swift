//
//  SheetView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/04.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SheetViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TitleTextField(content: $viewModel.memo.title)
                DeadlinePicker(date: $viewModel.memo.deadline)
                BodyTextField(content: $viewModel.memo.body)
            }
            .sheetBackground()
            .disabled(!viewModel.canEditable)
            .navigationTitle(viewModel.memo.category.description)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: viewModel.canEditable ? AnyView(cancelButton) : AnyView(editButton),
                trailing: doneButton
            )
        }
        .navigationViewStyle(.stack)
    }
    
    var editButton: some View {
        Button("Edit") {
            viewModel.canEditable.toggle()
        }
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            dismiss()
            viewModel.canEditable = true
        }
    }
    
    var doneButton: some View {
        Button("Done") {
            viewModel.saveMemo()
            dismiss()
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(viewModel: SheetViewModel(memo: Memo(title: "", body: "", deadline: .now, category: .toDo), canEditable: true, memoManager: MemoManager()))
    }
}
