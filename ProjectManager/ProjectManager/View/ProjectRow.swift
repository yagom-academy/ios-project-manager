//
//  ProjectRow.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

struct ProjectRow: View {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("책상정리")
                    .font(.title2)
                Text("집중이 안될땐 역시나 책상정리")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                Text(dateFormatter.string(from: Date()))
                    .font(.callout)
            }
            Spacer()
        }
    }
}

struct ProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRow()
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
