//
//  RegisterView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var contentViewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            EditElementView(contentViewModel: contentViewModel)
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
        EditView(contentViewModel: ContentViewModel())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
