//
//  MainContainer.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct MainContainer: View {
    @StateObject private var viewModel = MemoViewModel()
    @State var isEdited = false

    var body: some View {
        NavigationView {
            HStack(
                alignment: .center,
                spacing: UIStyle.minInsetAmount
            ) {
                ForEach(Memo.State.allCases) {
                    MemoList(
                        viewModel: viewModel,
                        state: $0,
                        onTap: {
                            isEdited.toggle()
                        }
                    )
                        .backgroundColor(.basic)
                }
            }
            .backgroundColor(
                .myGray
            )
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdited.toggle()
                        viewModel.joinToCreateMemo()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(
            isPresented: $isEdited,
            onDismiss: {
                viewModel.afterEdit()
            },
            content: {
                MemoView(viewModel: viewModel, isShow: $isEdited)
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainer()
    }
}
