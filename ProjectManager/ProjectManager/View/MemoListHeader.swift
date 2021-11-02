//
//  MemoListHeader.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/31.
//

import SwiftUI

struct MemoListHeader: View {
    let title: String
    var number: Int

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)

            NumberBall(number: number)
        }
    }
}

struct MemoListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MemoListHeader(
            title: "TODO",
            number: 1
        )
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
