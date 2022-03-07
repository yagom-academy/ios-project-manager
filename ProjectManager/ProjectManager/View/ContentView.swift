//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                
            }.navigationBarTitle("Project Manager", displayMode: .inline)
        }.navigationViewStyle(.stack)
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro (12.9-inch)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
