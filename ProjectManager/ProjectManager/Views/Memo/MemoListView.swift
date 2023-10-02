//
//  MemoListView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoListView: View {
    @State private var currentMemo: Memo? = nil
    var memos: [Memo]
    var category: Memo.Category

    var body: some View {
        List {
            Section {
                ForEach(memos) { memo in
                    VStack(alignment: .leading, spacing: 2) {
                        HorizontalSpacing()
                        
                        MemoRow(memo: memo)
                            .swipeActions {
                                Button {
                                    // Delete
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
                        currentMemo = memo
                    }
                }
                .sheet(item: $currentMemo) { memo in
                    MemoDetail(memo: memo)
                }
            } header: {
                ListHeader(category: category.description, memoCount: memos.count)
            }
        }
        .listStyle(.grouped)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView(memos: ModelData().toDoList, category: .doing)
    }
}
