//
//  TodoRow.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoRow: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("제목")
                .font(.title3)
            Text("본문을 이렇게 많이 써볼려고 함")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 1.0)
            Text("2021. 10. 28.")
                .font(.footnote)
        }
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoRow()
    }
}
