//
//  HistoryRow.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/13.
//

import SwiftUI

struct HistoryRow: View {
    let history: HistoryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(history.modifiedMemoTitle)
                    .font(.title2)
                    .foregroundColor(.blue)
                Text("메모를")
                Text(history.modifiedType.description)
                    .font(.title3)
                    .foregroundColor(history.modifiedTypeColor)
                Text("하였습니다.")
            }
            HStack {
                Text(history.modifiedDate, style: .date)
                Text(history.modifiedDate, style: .time)
            }
            .foregroundColor(.gray)
        }
        .padding([.leading, .bottom, .trailing])
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(history: HistoryViewModel(history: History()))
    }
}
