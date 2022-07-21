//
//  RegisterView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/14.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var registerViewModel: RegisterViewModel
    
    var body: some View {
        NavigationView {
            RegisterElementView(registerViewModel: registerViewModel)
                .navigationTitle(TaskType.todo.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(.systemGray5)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            registerViewModel.appendTask()
                            presentationMode.wrappedValue.dismiss()
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
        RegisterView(registerViewModel: RegisterViewModel(withService: TaskManagementService()))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
