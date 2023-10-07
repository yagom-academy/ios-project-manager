//
//  MemoListView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var modelData: ModelData
    @State private var currentMemo: Memo? = nil
    private var category: Memo.Category
    
    init(category: Memo.Category) {
        self.category = category
    }

    var body: some View {
        VStack(spacing: 0) {
            ListHeader(
                category: category.description,
                memoCount: modelData.filterMemo(by: category).count
            )
            
            List {
                ForEach(modelData.filterMemo(by: category)) { memo in
                    VStack(alignment: .leading, spacing: 2) {
                        HorizontalSpacing()
                        
                        MemoRow(memo: memo)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    modelData.deleteMemo(memo)
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
                    SheetView(viewModel: SheetViewModel(memo: memo, canEditable: false))
                }
            }
            .background(ColorSet.background)
            .listStyle(.plain)
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView(category: .doing)
            .environmentObject(ModelData())
    }
}
