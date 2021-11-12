//
//  HistoryRow.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/13.
//

import SwiftUI

struct HistoryRow: View {
    private let title = "갓피로2"
    private let date = Date()
    private let updateType = UpdateType.modify
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title2)
                    .foregroundColor(.blue)
                Text("메모를")
                Text(updateType.description)
                    .font(.title3)
                    .foregroundColor(.orange)
                Text("하였습니다.")
            }
            HStack {
                Text(date, style: .date)
                Text(date, style: .time)
            }
            .foregroundColor(.gray)
        }
        .padding([.leading, .bottom, .trailing])
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow()
    }
}
