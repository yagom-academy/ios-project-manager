//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/01.
//

import SwiftUI

struct MainScene: View {
    @EnvironmentObject var viewModel: ProjectManagerViewModel
    @State var isShowEditScene: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                TaskListView(taskStatus: .todo)
                TaskListView(taskStatus: .doing)
                TaskListView(taskStatus: .done)
            }
            .navigationBarTitle("Project Manager", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    AddButtonView(show: $isShowEditScene)
                        .sheet(isPresented: $isShowEditScene, onDismiss: nil) {
                            EditScene(showEditScene: $isShowEditScene)
                        }
                }
            }
        }.navigationViewStyle(.stack)
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProjectManagerViewModel()
        MainScene()
            .environmentObject(viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro (12.9-inch)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
