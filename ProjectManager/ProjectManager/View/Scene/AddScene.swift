//
//  EditScene.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct AddScene: View {
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var limitDate: Date = Date()
    @Binding var showAddScene: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TaskEditView(
                    title: $title,
                    content: $content,
                    limitDate: $limitDate
                )
            }
            .padding()
            .navigationBarTitle("TODO", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DoneButtonView(
                        show: $showAddScene,
                        title: $title,
                        content: $content,
                        limitDate: $limitDate
                    )
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissButtonView(show: $showAddScene)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
