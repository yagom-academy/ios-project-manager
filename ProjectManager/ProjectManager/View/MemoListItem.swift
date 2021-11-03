//
//  MemoListItem.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct MemoListItem: View {
    @ObservedObject var viewModel: MemoViewModel
    var memo: Memo

    private let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.locale = Locale.current
        result.dateStyle = .medium
        result.timeStyle = .none
        return result
    }()

    private func yyyyMMdd(about date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)

            VStack(
                alignment: .leading,
                spacing: 1
            ) {
                Text(memo.title)
                    .font(.title3)
                    .lineLimit(1)
                    .padding(
                        UIStyle.minInsetAmount
                    )

                Text(memo.body)
                    .font(.body)
                    .lineLimit(3)
                    .padding(
                        UIStyle.minInsetAmount
                    )

                Text(yyyyMMdd(about: memo.date))
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
        MemoListItem(
            viewModel: .init(),
            memo: Memo(
                id: UUID(),
                title: "test",
                body: "body",
                date: Date(),
                state: .todo
            )
        )
            .previewLayout(
                .fixed(width: 200, height: 200)
            )
    }
}
