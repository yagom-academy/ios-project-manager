//
//  TodoView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct TodoView: View {
    var body: some View {
        HStack {
            Text("TODO")
                .font(.largeTitle)
                .foregroundColor(.black)
            ZStack {
            Circle()
                .frame(width: 25, height: 25)
                Text("5")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView().previewLayout(.sizeThatFits)
    }
}
