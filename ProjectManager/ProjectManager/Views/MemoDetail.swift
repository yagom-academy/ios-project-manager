//
//  MemoDetail.swift
//  ProjectManager
//
//  Created by MARY on 2023/09/26.
//

import SwiftUI

struct MemoDetail: View {
    @EnvironmentObject var modelData: ModelData
    var memo: Memo
    
    var memoIndex: Int {
        modelData.memos.firstIndex(where: { $0.id == memo.id })!
    }
    
    var body: some View {
        TextField("Title", text: $modelData.memos[memoIndex].body)
    }
}

struct MemoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetail(memo: ModelData().memos[0])
            .environmentObject(ModelData())
    }
}
