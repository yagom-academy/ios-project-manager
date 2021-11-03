//
//  ProjectList.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

struct ProjectList: View {
    
    var body: some View {
        List {
            Section(header: header) {
                ProjectRow()
            }
        }
        .listStyle(GroupedListStyle())
        .background(Color(.systemGray5))
    }
    
    var header: some View {
        HStack {
            Text("TODO")
                .foregroundColor(.primary)
                .font(.title)
            Image(systemName: "1.circle.fill")
                .font(.title2)
                .foregroundColor(.black)
        }
    }
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}
