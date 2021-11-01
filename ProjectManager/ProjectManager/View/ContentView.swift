//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/10/26.
//

import SwiftUI



struct ContentView: View {
    @State private var isPopoverPresented = false
    
    var body: some View {
        Button {
            isPopoverPresented = true
        } label: {
            Image(systemName: "plus")
                .font(.largeTitle)
        }
        .sheet(isPresented: $isPopoverPresented) {
            EditPopover(isPresented: $isPopoverPresented)
        }
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
