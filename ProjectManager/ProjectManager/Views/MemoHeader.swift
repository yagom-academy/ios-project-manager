//
//  MemoHeader.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct MemoHeader: View {
    let headerTitle: String
    var rowCount: String
    
    var body: some View {
        HStack {
            Text(headerTitle)
                .font(.largeTitle)
            Text(rowCount)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .background(Circle())
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
    }
}

struct MemoHeader_Previews: PreviewProvider {
    static var previews: some View {
        MemoHeader(headerTitle: "TODO", rowCount: "23")
    }
}
