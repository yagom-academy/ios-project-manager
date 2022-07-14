//
//  ContentView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @ObservedObject var contentViewModel: ContentViewModel
    @State private var isShowingPopover = false
    
    var body: some View {
        
        NavigationView {
            HStack {
                TodoView(contentViewModel: contentViewModel)
                DoingView(contentViewModel: contentViewModel)
                DoneView(contentViewModel: contentViewModel)
            }
            .background(.gray)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }.sheet(isPresented: $showSheet) {
                        RegisterView(contentViewModel: contentViewModel)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
