//
//  ToDoRow.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct ToDoRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("제목")
                    .font(.title)
                Text("설명")
                    .font(.body)
                    .foregroundColor(.gray)
                Text("기한")
                    .font(.caption)
            }
            Spacer()
        }
        .padding()
    }
}

struct ToDoRow_Previews: PreviewProvider {
    static var previews: some View {
        ToDoRow()
    }
}
