//
//  ContentView.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isDetailViewPresented = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .systemGray5
    }
    
    var body: some View {
        NavigationView {
            HStack(spacing: 10) {
                MemoList(isDetailViewPresented: $isDetailViewPresented)
                MemoList(isDetailViewPresented: $isDetailViewPresented)
                MemoList(isDetailViewPresented: $isDetailViewPresented)
            }
            .background(Color(UIColor.systemGray3))
            .navigationTitle(Text("Project Manager"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    self.isDetailViewPresented = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isDetailViewPresented) {
                    MemoDetail()
                }
            })
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
