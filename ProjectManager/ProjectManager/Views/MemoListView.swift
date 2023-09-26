//
//  MemoListView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoListView: View {
    var memos: [Memo]
    
    var body: some View {
        List {
            Section {
                ForEach(memos.indices, id: \.self) { index in
                    NavigationLink {
                        MemoDetail(memo: memos[index])
                    } label: {
                        MemoRow(memo: memos[index])
                    }
                }
            } header: {
                HStack {
                    Text(memos.first?.category.description ?? "")
                    Image(systemName: "\(memos.count).circle.fill")
                }
                .font(.largeTitle)
                .foregroundColor(.primary)
            }
        }
        .listStyle(.grouped)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView(memos: ModelData().memos)
    }
}
