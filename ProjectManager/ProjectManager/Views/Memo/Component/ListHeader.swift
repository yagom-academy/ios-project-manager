//
//  ListHeader.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/28.
//

import SwiftUI

struct ListHeader: View {
    var category: String
    var memoCount: Int
    
    var body: some View {
        HStack {
            Text(category)
            Image(systemName: "\(memoCount).circle.fill")
            Spacer()
        }
        .font(.largeTitle)
        .foregroundColor(.primary)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
}

struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(category: "TODO", memoCount: 5)
    }
}
