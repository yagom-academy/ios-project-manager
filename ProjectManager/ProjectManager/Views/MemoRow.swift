//
//  MemoRow.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct MemoRow: View {
    let memo: Memo
    @State private var isPopoverShown = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(memo.title)
                    .font(.title)
                Text(memo.description)
                    .font(.body)
                    .foregroundColor(.gray)
                Text(memo.date.description)
                    .font(.caption)
            }
            Spacer()
        }
        .onLongPressGesture {
            isPopoverShown = true
        }
        .popover(isPresented: $isPopoverShown) {
            MemoPopover(isPopoverShown: $isPopoverShown, selectedMemo: memo)
        }
    }
}

struct MemoRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(memo: Memo(title: "", description: "", date: Date()))
    }
}
