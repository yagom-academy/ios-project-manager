//
//  MemoListHeader.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/31.
//

import SwiftUI

struct MemoListHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()

            NumberBall(number: 1)
        }
    }
}

struct MemoListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MemoListHeader(title: "TODO")
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
