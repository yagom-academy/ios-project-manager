//
//  MemoList.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct MemoList: View {
    @EnvironmentObject var viewModel: MemoListViewModel
    let state: MemoState
    
    var body: some View {
        let list = viewModel.memoViewModels[state.indexValue]
        VStack(alignment: .leading, spacing: 3) {
            MemoHeader(headerTitle: state.description, rowCount: list.count.description)
            
            List {
                ForEach(list, id: \.memoId) { memo in
                    MemoRow(memo: memo)
                        .highPriorityGesture(TapGesture()
                                                .onEnded({ _ in
                            viewModel.didTouchUpCell(memo)
                        }))
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        viewModel.didSwipeCell(list[index])
                    }
                }
            }
            .listStyle(.plain)
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct MemoList_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(state: .toDo)
    }
}
