//
//  ContentView.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/09/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text("by Minsup and Whales")
            }
            .padding()
            .background(.ultraThickMaterial)
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
