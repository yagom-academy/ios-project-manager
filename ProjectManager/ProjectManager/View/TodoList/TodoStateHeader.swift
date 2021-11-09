//
//  TodoStateHeader.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/11/09.
//

import SwiftUI

struct TodoStateHeader: View {
    let headerTitle: String
    let todoListCount: String
    
    var body: some View {
        HStack {
            Text(headerTitle)
                .font(.title)
                .foregroundColor(.black)
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.black)
                Text(todoListCount)
                    .foregroundColor(.white)
            }
            .font(.title2)
        }
    }
}

struct TodoStateHeader_Previews: PreviewProvider {
    static var previews: some View {
        TodoStateHeader(headerTitle: "Todo", todoListCount: "3")
    }
}
