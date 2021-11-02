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
    let onLongPress: () -> Void

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
                        ForEach(items) { item in
                            MemoListItem(item: item)
                                .padding(.bottom, UIStyle.minInsetAmount)
                                .onTapGesture(perform: onTap)
                                .onLongPressGesture(perform: onLongPress)
                                .swipe {
                                    guard let index = items.firstIndex(of: item) else {
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
            onTap: {},
            onLongPress: {}
        )
            .previewLayout(
                .fixed(
                    width: 400,
                    height: 600
                )
            )
    }
}
