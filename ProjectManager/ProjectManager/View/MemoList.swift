//
//  MemoList.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/27.
//

import SwiftUI

struct MemoList: View {
    private let onTap: () -> Void
    private let onLongPress: () -> Void
    let title: String

    init(
        title: String,
        onTap: @escaping () -> Void,
        onLongPress: @escaping () -> Void
    ) {
        self.title = title
        self.onTap = onTap
        self.onLongPress = onLongPress
    }

    // TODO: - add a press action, a longPress actions and a swipe action to each item
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: UIStyle.minInsetAmount
        ) {
            MemoListHeader(title: title)
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
                        ForEach(0..<9) { _ in
                            MemoListItem()
                                .padding(.bottom, UIStyle.minInsetAmount)
                                .onTapGesture(perform: onTap)
                                .onLongPressGesture(perform: onLongPress)

                        }
                        // TODO: - add a swipe action to delete
                    }
                }
            }
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(
            title: "TODO",
            onTap: {
                print("!")
            },
            onLongPress: {
                print("?")
            }
        )
            .previewLayout(
                .fixed(
                    width: 400,
                    height: 600
                )
            )
    }
}
