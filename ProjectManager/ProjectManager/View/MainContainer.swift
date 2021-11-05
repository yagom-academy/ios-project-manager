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
                ForEach(Memo.State.allCases, id: \.self) { state in
                    let memoList = viewModel.list(about: state)

                    MemoList(
                        title: state.description,
                        itemCount: memoList.count
                    ) {
                        ForEach(memoList) { memo in
                            MemoListItem(viewModel: viewModel, memo: memo)
                                .padding(.bottom, UIStyle.minInsetAmount)
                                .onTapGesture {
                                    viewModel.joinToUpdate(memo)
                                    isEdited.toggle()
                                }
                                .swipeToDelete {
                                    guard let index = memoList.firstIndex(of: memo) else {
                                        return
                                    }

                                    viewModel.delete(at: index, from: state)
                                }
                        }
                    }
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
