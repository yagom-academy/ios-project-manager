//
//  ListTitle.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/29.
//

import SwiftUI

struct ListTitle: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Text("TODO")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ZStack {
                Capsule()
                    .frame(width: 44, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("1")
                    .foregroundColor(Color.white)
            }
            Spacer()
        })
        .padding()
    }
}

struct ListTitle_Previews: PreviewProvider {
    static var previews: some View {
        ListTitle()
            .previewLayout(.fixed(width: 400, height: 40))
    }
}
