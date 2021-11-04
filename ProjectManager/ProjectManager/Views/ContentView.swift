//
//  ContentView.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isDetailViewPresented = false
    @StateObject var viewModel = MemoViewModel()
    
    init() {
        UINavigationBar.appearance().backgroundColor = .systemGray5
    }
    
    var body: some View {
        NavigationView {
            HStack(spacing: 10) {
                ForEach(MemoState.allCases, id: \.self) { state in
                    MemoList(isDetailViewPresented: $isDetailViewPresented, state: state)
                }
            }
            .background(Color(UIColor.systemGray3))
            .navigationTitle(Text("Project Manager"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    self.isDetailViewPresented = true
                    viewModel.readyForAdd()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isDetailViewPresented) {
                    MemoDetail(memo: viewModel.presentedMemo, isDetailViewPresented: $isDetailViewPresented, accessMode: viewModel.accessMode)
                }
            })
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
