//
//  MemoList.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/27.
//

import SwiftUI

struct MemoList<ItemView>: View where ItemView: View {
    let title: String
    let itemCount: Int
    @ViewBuilder let builder: () -> ItemView

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: UIStyle.minInsetAmount
        ) {
            MemoListHeader(title: title, number: itemCount)
                .padding(UIStyle.minInsetAmount)

            Divider()
                .foregroundColor(.myGray)

            ScrollView {
                LazyVStack(
                    alignment: .leading,
                    spacing: UIStyle.minInsetAmount,
                    pinnedViews: PinnedScrollableViews()
                ) {
                    builder()
                }
            }
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(
            title: "TODO",
            itemCount: 1,
            builder: {
                Text("?")
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
