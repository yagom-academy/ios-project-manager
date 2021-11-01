//
//  TodoItemRow.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/01.
//

import SwiftUI

struct TodoItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! 2222Hello, World! Hello, World! Hello")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(.primary)
        
            Text("Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! 2222Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ")
                .lineLimit(3)
                .foregroundColor(.secondary)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 3, trailing: 0))
            
            Text("2021. 11. 1")
                .foregroundColor(.red)
        }
        .padding()
        
    }
}

struct TodoItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoItem()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
