//
//  MemoList.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/27.
//

import SwiftUI

struct MemoList: View {
    @ObservedObject var viewModel: MemoViewModel
    let state: Memo.State
    let onTap: () -> Void

    var body: some View {
        let memoList = viewModel.list(about: state)

        return VStack(
            alignment: .leading,
            spacing: UIStyle.minInsetAmount
        ) {
            MemoListHeader(
                title: state.description,
                number: memoList.count
            )
                .padding(
                    UIStyle.minInsetAmount
                )

            Divider()
                .foregroundColor(.myGray)

            ScrollView {
                LazyVStack(
                    alignment: .leading,
                    spacing: UIStyle.minInsetAmount,
                    pinnedViews: PinnedScrollableViews()
                ) {
                    ForEach(memoList) { memo in
                        MemoListItem(viewModel: viewModel, memo: memo)
                            .padding(.bottom, UIStyle.minInsetAmount)
                            .onTapGesture {
                                viewModel.joinToUpdate(memo)
                                onTap()
                            }
                            .swipeToDelete {
                                guard let index = memoList.firstIndex(of: memo) else {
                                    return
                                }

                                viewModel.delete(at: index, from: state)
                            }
                    }
                }
            }
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(
            viewModel: .init(),
            state: .todo,
            onTap: {}
        )
            .previewLayout(
                .fixed(
                    width: 400,
                    height: 600
                )
            )
    }
}
