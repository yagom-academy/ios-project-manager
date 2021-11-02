//
//  MemoListItem.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct MemoListItem: View {
    var item: Memo
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)

            VStack(
                alignment: .leading,
                spacing: 1
            ) {
                Text(item.title)
                    .font(.title3)
                    .lineLimit(1)
                    .padding(
                        UIStyle.minInsetAmount
                    )

                Text(item.body)
                    .font(.body)
                    .lineLimit(3)
                    .padding(
                        UIStyle.minInsetAmount
                    )

                Text(item.date.description)
                    .font(.callout)
                    .padding(
                        UIStyle.minInsetAmount
                    )
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        MemoListItem(item: Memo(
            id: UUID(),
            title: "test",
            body: "body",
            date: Date(),
            state: .todo
        ))
            .previewLayout(
                .fixed(width: 200, height: 200)
            )
    }
}
