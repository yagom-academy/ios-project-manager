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

    private var items: [Memo] {
        viewModel.list(about: state)
    }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: UIStyle.minInsetAmount
        ) {
            MemoListHeader(
                title: state.description,
                number: items.count
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
                    Group {
                        ForEach(items) { memo in
                            MemoListItem(item: memo)
                                .padding(.bottom, UIStyle.minInsetAmount)
                                .onTapGesture {
                                    viewModel.update(memo)
                                    onTap()
                                }
                                .onLongPressGesture {

                                }
                                .swipeToDelete {
                                    guard let index = items.firstIndex(of: memo) else {
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
