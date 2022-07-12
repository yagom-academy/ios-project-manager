//
//  RegisterView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    var contentViewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            RegisterElementsView(contentViewModel: contentViewModel)
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
                        print("\(self.contentViewModel.data.title)")
                        print("\(self.contentViewModel.data.dueDate.convertDateToString)")
                        print("\(self.contentViewModel.data.body)")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(contentViewModel: ContentViewModel())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
