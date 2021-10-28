//
//  ToDoHeader.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/10/28.
//

import SwiftUI

struct ToDoHeader: View {
    let headerTitle: String
    var rowCount: String
    
    var body: some View {
        HStack {
            Text(headerTitle)
                .font(.largeTitle)
            Text("12")
                .font(.title3)
                .foregroundColor(.white)
                .background(Color.black).clipShape(Circle())
                
        }
    }
}

struct ToDoHeader_Previews: PreviewProvider {
    static var previews: some View {
        ToDoHeader(headerTitle: "TODO", rowCount: "23")
    }
}
