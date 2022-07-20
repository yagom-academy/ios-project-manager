//
//  EditView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var editViewModel = EditViewModel()
    var cellIndex: Int
    
    var body: some View {
        NavigationView {
            EditElementView(editViewModel: editViewModel, cellIndex: cellIndex)
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editViewModel.appendTask()
                        dismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(contentViewModel: SomeViewModel(), cellIndex: 0)
//.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
