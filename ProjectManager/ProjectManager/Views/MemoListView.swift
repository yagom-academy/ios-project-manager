//
//  MemoListView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoListView: View {
    var list: MemoList
    
    var body: some View {
        List {
            Section {
                ForEach(list.memos) { memo in
                    MemoRow(memo: memo)
                }
            } header: {
                HStack{
                    Text(list.category.description)
                    Image(systemName: "\(list.memos.count).circle.fill")
                }
                .font(.largeTitle)
                .foregroundColor(.primary)
            }
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView(list: ModelData().toDoList)
    }
}
