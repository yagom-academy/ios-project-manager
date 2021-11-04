//
//  MemoList.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct MemoList: View {
    @EnvironmentObject var viewModel: MemoViewModel
    @Binding var isDetailViewPresented: Bool
    let state: MemoState
    
    var body: some View {
        let list = viewModel.memos[state.indexValue]
        VStack(alignment: .leading, spacing: 3) {
            MemoHeader(headerTitle: state.description, rowCount: list.count.description)
            
            List {
                ForEach(list) { memo in
                    MemoRow(memo: memo)
                        .onTapGesture {
                            isDetailViewPresented = true
                            viewModel.readyForRead(memo)
                        }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        viewModel.delete(list[index])
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
        MemoList(isDetailViewPresented: .constant(false), state: .toDo)
    }
}
