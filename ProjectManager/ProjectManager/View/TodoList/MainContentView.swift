//
//  MainContentView.swift
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
            GeometryReader { geometry in
                ScrollView([]) {
                    HStack {
                        ForEach(TodoList.State.allCases, id: \.self) { eachCase in
                            TodoStateList(todoState: eachCase)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
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
                        TodoModalView(isPresented: $isShowingModalView, viewPurpose: .add, todo: Todo())
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: TodoViewModel())
    }
}
