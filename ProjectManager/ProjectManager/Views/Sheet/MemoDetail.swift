//
//  MemoDetail.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/26.
//

import SwiftUI

struct MemoDetail: View {
    @EnvironmentObject private var modelData: ModelData
    private let memo: Memo
    
    private var memoIndex: Int {
        modelData.memos.firstIndex(where: { $0.id == memo.id })!
    }
    
    init(memo: Memo) {
        self.memo = memo
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TitleTextField(content: $modelData.memos[memoIndex].title)
                DeadlinePicker(date: $modelData.memos[memoIndex].deadline)
                BodyTextField(content: $modelData.memos[memoIndex].body)
            }
            .sheetBackground()
            .navigationTitle(memo.category.description)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button {
                        
                    } label: {
                        Text("Edit")
                    },
                trailing:
                    Button {
                        
                    } label: {
                        Text("Done")
                    }
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetail(memo: ModelData().memos[0])
            .environmentObject(ModelData())
    }
}
