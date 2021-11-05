//
//  ProjectManagerContentView.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/10/31.
//

import SwiftUI

struct ContainerView: View {
    @StateObject var viewModel = TaskListViewModel()
    @State private var isShowingAddNew = false

    var body: some View {
        NavigationView {
            HStack(alignment: .firstTextBaseline) {
                TaskListView(taskStatus: .TODO ,viewModel: viewModel)
                TaskListView(taskStatus: .DOING ,viewModel: viewModel)
                TaskListView(taskStatus: .DONE ,viewModel: viewModel)
            }
            .padding(.top)
            .padding(.bottom)
            .navigationTitle("Project Manager")
            .navigationBarItems(trailing: addNewButton)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var addNewButton: some View {
        Button {
            isShowingAddNew.toggle()
        } label: {
            Image(systemName: "plus")
        }

    }
}
