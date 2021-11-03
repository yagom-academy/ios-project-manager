//
//  ContentView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/26.
//

import SwiftUI

struct MainContentView: View {
    @State private var isShowingModalView: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(Todo.Completion.allCases, id: \.self) { eachCase in
                    TodoList(completionState: eachCase)
                }
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(
                        action: { self.isShowingModalView.toggle() },
                         label: { Label("", systemImage: "plus") }
                    )
                    .sheet(isPresented: self.$isShowingModalView) {
                        TodoModalView(isPresented: $isShowingModalView, modalType: .add, selectedTodo: nil)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .environmentObject(TodoViewModel())
    }
}
