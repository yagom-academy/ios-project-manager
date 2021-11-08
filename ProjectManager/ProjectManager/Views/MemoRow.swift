//
//  MemoRow.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct MemoRow: View {
    let memo: MemoViewModel
    @State private var isPopoverShown = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(memo.memoTitle)
                    .font(.title)
                    .lineLimit(1)
                Text(memo.memoDescription)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                if isPastDeadline() {
                    Text(memo.memoDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.red)
                } else {
                    Text(memo.memoDate, style: .date)
                        .font(.caption)
                }
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
    
    private func isPastDeadline() -> Bool {
        let today = Date()
        let memoDate = memo.memoDate
        let calendar = Calendar.current
        if calendar.compare(today, to: memoDate, toGranularity: .day) == .orderedDescending {
            return true
        }
        return false
    }
}

struct MemoRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(memo: MemoViewModel())
    }
}
