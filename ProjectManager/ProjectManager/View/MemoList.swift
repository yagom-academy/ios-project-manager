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
        VStack(alignment: .leading, spacing: 4) {
            MemoListHeader(title: title)

            ScrollView {
                LazyVStack(
                    alignment: .leading,
                    spacing: 4,
                    pinnedViews: PinnedScrollableViews()
                ) {

                    Group {
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                        MemoListItem()
                    }
                }
            }
        }
        .padding()

    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(title: "TODO")
    }
}
