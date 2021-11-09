//
//  ContentView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/26.
//

import SwiftUI

struct MainContentView: View {
    @StateObject var viewModel: TodoViewModel
    @State private var isShowingModalView: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(TodoList.Completion.allCases, id: \.self) { eachCase in
                    TodoStateList(completionState: eachCase)
                        .environmentObject(viewModel)
                }
            }
            .background(Color.gray.opacity(0.3))
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(
                        action: { isShowingModalView.toggle() },
                         label: { Label("", systemImage: "plus") }
                    )
                    .sheet(isPresented: $isShowingModalView) {
                        TodoModalView(isPresented: $isShowingModalView, modalType: .add, selectedTodo: nil)
                            .environmentObject(viewModel)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: TodoViewModel())
    }
}
