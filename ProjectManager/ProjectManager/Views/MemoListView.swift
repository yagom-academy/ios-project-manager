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
                        Rectangle()
                            .fill(ColorSet.background)
                            .frame(height: 10)
                            .overlay(
                                Rectangle()
                                    .frame(width: nil, height: 3)
                                    .foregroundColor(ColorSet.border),
                                alignment: .top
                            )
                        
                        MemoRow(memo: memo)
                            .swipeActions {
                                Button {
                                    // Delete
                                } label: {
                                    Text("Delete")
                                }
                            }
                            .padding()
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
                HStack {
                    Text(category.description)
                    Image(systemName: "\(memos.count).circle.fill")
                    Spacer()
                }
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
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
