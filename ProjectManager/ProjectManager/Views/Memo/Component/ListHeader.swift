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
        VStack(spacing: 0) {
            HStack {
                Text(category)
                Image(systemName: "\(memoCount).circle.fill")
                Spacer()
            }
            .font(.largeTitle)
            .foregroundColor(.primary)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
            
            HorizontalDivider()
        }
        .listRowInsets(EdgeInsets())
        .background(ColorSet.background)
    }
}

struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(category: "TODO", memoCount: 5)
    }
}
