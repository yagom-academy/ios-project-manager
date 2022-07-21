//
//  RegisterView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/14.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    
    var body: some View {
        NavigationView {
            RegisterElementView(registerViewModel: registerViewModel)
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        registerViewModel.appendTask()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView(contentViewModel: SomeViewModel())
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
