//
//  EditScene.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct EditScene: View {
    @ObservedObject var viewModel: ProjectManagerViewModel
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var limitDate: Date = Date()
    @Binding var showEditScene: Bool
    
    var task: Task? = nil
    
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
                        show: $showEditScene,
                        title: $title,
                        content: $content,
                        limitDate: $limitDate,
                        viewModel: viewModel,
                        task: task
                    )
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissButtonView(show: $showEditScene)
                }
            }
        }.onAppear {
            self.title = self.task?.title ?? ""
            self.content = self.task?.content ?? ""
            self.limitDate = self.task?.limitDate ?? Date()
        }.navigationViewStyle(.stack)
    }
}
