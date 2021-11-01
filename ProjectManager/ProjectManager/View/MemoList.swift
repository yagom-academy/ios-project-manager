//
//  List.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/27.
//

import SwiftUI

struct MemoList: View {
    let title: String
    
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
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                        MemoListItem()
                            .padding(.bottom, UIStyle.minInsetAmount)
                    }
                }
            }
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(title: "TODO")
            .previewLayout(
                .fixed(
                    width: 400,
                    height: 600
                )
            )
    }
}
