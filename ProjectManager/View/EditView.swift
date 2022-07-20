//
//  EditView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var contentViewModel: ContentViewModel
    var cellIndex: Int
    
    var body: some View {
        NavigationView {
            EditElementView(taskViewModel: contentViewModel.data, cellIndex: cellIndex)
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
                        contentViewModel.appendData()
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

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(contentViewModel: ContentViewModel(), cellIndex: 0)
.previewInterfaceOrientation(.landscapeLeft)
    }
}
