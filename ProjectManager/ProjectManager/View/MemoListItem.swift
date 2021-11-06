//
//  MemoListItem.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct MemoListItem: View {
    @ObservedObject var viewModel: MemoListItemViewModel

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 1) {
                Text(viewModel.memo.title)
                    .font(.title3)
                    .lineLimit(1)
                    .padding(UIStyle.minInsetAmount)

                Text(viewModel.memo.body)
                    .font(.body)
                    .lineLimit(3)
                    .padding(UIStyle.minInsetAmount)

                Text(viewModel.yyyyMMdd(from: viewModel.memo.date))
                    .font(.callout)
                    .foregroundColor(viewModel.color(about: viewModel.memo))
                    .padding(UIStyle.minInsetAmount)
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        MemoListItem(
            viewModel: .init(memo: Memo(
                id: UUID(),
                title: "title",
                body: "body",
                date: Date(),
                state: .todo
            ))
        )
            .previewLayout(
                .fixed(width: 200, height: 200)
            )
    }
}
