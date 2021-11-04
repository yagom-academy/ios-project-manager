//
//  MemoList.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct MemoList: View {
    @Binding var isDetailViewPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            MemoHeader(headerTitle: "TODO", rowCount: "12")
            
            List {
                ForEach(dummyMemos) { memo in
                    MemoRow(memo: memo)
                        .onTapGesture {
                            isDetailViewPresented = true
                        }
                }
                .onDelete { indexSet in
                    
                }
            }
            .listStyle(.plain)
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct MemoList_Previews: PreviewProvider {
    static var previews: some View {
        MemoList(isDetailViewPresented: .constant(false))
    }
}
