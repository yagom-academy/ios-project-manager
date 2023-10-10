//
//  MemoHomeView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoHomeView: View {
    @ObservedObject var viewModel = MemoHomeViewModel(memoManager: MemoManager())
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorSet.navigationBarBackground.edgesIgnoringSafeArea(.all)
                ColorSet.backgroundBetweenLists
                
                HStack(spacing: 4) {
                    ForEach(viewModel.categories, id: \.description) {
                        MemoListView(
                            viewModel: MemoListViewModel(category: $0,
                                                         memoManager: viewModel.memoManager)
                        )
                    }
                }
                .clipped()
                .navigationBarTitle("Project Manager")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing:
                        Button {
                            viewModel.showDetail.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $viewModel.showDetail) {
                            SheetView(
                                viewModel: SheetViewModel(memo: viewModel.newMemo,
                                                          canEditable: true,
                                                          memoManager: viewModel.memoManager)
                            )
                        }
                )
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoHome_Previews: PreviewProvider {
    static var previews: some View {
        MemoHomeView()
    }
}
