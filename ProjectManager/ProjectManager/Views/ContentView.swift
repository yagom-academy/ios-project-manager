//
//  ContentView.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MemoListViewModel()
    @StateObject var historyListViewModel = HistoryListViewModel()
    
    init() {
        UINavigationBar.appearance().backgroundColor = .systemGray5
    }
    
    var body: some View {
        NavigationView {
            HStack(spacing: 10) {
                ForEach(MemoState.allCases, id: \.self) { state in
                    MemoList(state: state)
                }
            }
            .background(Color(UIColor.systemGray3))
            .navigationTitle(Text("Project Manager"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        historyListViewModel.didTouchUpHistoryButton()
                    } label: {
                        Text("History")
                    }
                    .popover(isPresented: $historyListViewModel.isHistoryPopoverShown) {
                        HistoryPopover()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.didTouchUpPlusButton()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $viewModel.isDetaileViewPresented) {
                        MemoDetail()
                    }
                }
            })
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
        .onAppear {
            viewModel.viewOnAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
