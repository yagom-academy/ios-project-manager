//
//  MemoRow.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct MemoRow: View {
    let memo: Memo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(memo.title)
                    .font(.title)
                Text(memo.description)
                    .font(.body)
                    .foregroundColor(.gray)
                if isPastDeadline() {
                    Text(memo.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.red)
                } else {
                    Text(memo.date, style: .date)
                        .font(.caption)
                }
            }
            Spacer()
        }
    }
    
    private func isPastDeadline() -> Bool {
        let today = Date()
        let memoDate = memo.date
        let calendar = Calendar.current
        if calendar.compare(today, to: memoDate, toGranularity: .day) == .orderedDescending {
            return true
        }
        return false
    }
}

struct MemoRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(memo: Memo(title: "", description: "", date: Date()))
    }
}
