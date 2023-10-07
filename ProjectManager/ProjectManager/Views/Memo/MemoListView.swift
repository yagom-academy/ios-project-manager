//
//  MemoListView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoListView: View {
    @ObservedObject var viewModel: MemoListViewModel

    var body: some View {
        VStack(spacing: 0) {
            ListHeader(
                category: viewModel.category.description,
                memoCount: viewModel.memos.count
            )
            
            List {
                ForEach(viewModel.memos) { memo in
                    VStack(alignment: .leading, spacing: 2) {
                        HorizontalSpacing()
                        
                        MemoRow(memo: memo)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteMemo(memo)
                                } label: {
                                    Text("Delete")
                                }
                            }
                            .padding()
                        
                        HorizontalDivider()
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedMemo = memo
                    }
                }
                .sheet(item: $viewModel.selectedMemo, onDismiss: {
                    viewModel.update()
                }){ memo in
                    SheetView(
                        viewModel: SheetViewModel(memo: memo,
                                                  canEditable: false,
                                                  memoManager: viewModel.memoManager)
                    )
                }
            }
            .background(ColorSet.background)
            .listStyle(.plain)
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView(viewModel: MemoListViewModel(category: .toDo, memoManager: MemoManager()))
    }
}
