//
//  TodoListHeaderView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import SwiftUI

struct TodoListHeaderView: View {
    
    let title: String
    let count: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Arial",size: 40))
            
            Circle()
                .frame(width: 30, height: 30, alignment: .center)
                .overlay(Text("\(count)")
                            .font(.custom("Arial",size: 25))
                            .foregroundColor(Color.white)
                )
            
            Spacer()
        }
        .padding()
        .background(Color.init(UIColor(red: 239/256,
                                       green: 239/256,
                                       blue: 239/256,
                                       alpha: 1)))
    }
}

struct TodoListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListHeaderView(title: "DONE", count: 3)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
