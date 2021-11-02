//
//  ContentView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/26.
//

import SwiftUI

struct MainContentView: View {
    @State var showModalView = false
    
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
                        action: { self.showModalView.toggle() },
                         label: { Label("", systemImage: "plus") }
                    )
                        .sheet(isPresented: self.$showModalView) {
                            TodoModalView()
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
