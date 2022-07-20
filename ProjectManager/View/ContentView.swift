//
//  ContentView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            AllListView()
            .background(.gray)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        contentViewModel.toggleShowingSheet()
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }.sheet(isPresented: $contentViewModel.isShowingSheet) {
                        RegisterView()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(contentViewModel: SomeViewModel())
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
