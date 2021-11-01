//
//  ListItem.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct MemoListItem: View {

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)

            VStack(
                alignment: .leading,
                spacing: 1
            ) {
                Text("title")
                    .font(.title3)
                    .lineLimit(1)
                    .padding(
                        UIStyle.minInsetAmount
                    )

                Text("""
    asdafasdsaf
    asdsafasfasd
    asfasdsadf
    asdasfafasf
    """)
                    .font(.body)
                    .lineLimit(3)
                    .padding(
                        UIStyle.minInsetAmount
                    )

                Text("2021.01.01")
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
        MemoListItem()
            .previewLayout(
                .fixed(width: 200, height: 200)
            )
    }
}
