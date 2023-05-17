//
//  SwiftUIList.swift
//  ProjectManager
//
//  Created by 김성준 on 2023/05/17.
//

import SwiftUI

struct SwiftUIList: View {
    var body: some View {
        
        Form{
            Section(header: Text("Todo")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.light)) {
                List() {
                    Text("안녕")
                    Text("안녕")
                    Text("안녕")
                }
            }
        }
        
   
        
    }
}

struct SwiftUIList_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIList()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
