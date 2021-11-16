//
//  ContentView.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/10/28.
//

import SwiftUI

struct ProjectManagerView: View {
    @ObservedObject var viewModel: ManagerViewModel
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(Project.Status.allCases, id: \.self) { status in
                    ProjectList(viewModel: viewModel.listViewModel(of: status))
                }
            }
            .padding(0.2)
            .background(Color(.systemGray4))
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: addButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(viewModel)
    }
    
    var addButton: some View {
        Button {
            viewModel.addTapped = true
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectManagerView(viewModel: ManagerViewModel())
            .previewLayout(.fixed(width: 1136, height: 820))
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.verticalSizeClass, .compact)
    }
}
