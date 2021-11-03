//
//  ContentView.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isDetailViewPresented = false
    
    var body: some View {
        
        VStack {
            ZStack {
                Text("Project Manager")
                HStack {
                    Spacer()
                    Button {
                        self.isDetailViewPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isDetailViewPresented) {
                        ToDoDetail()
                    }
                }
                .padding()
            }
            HStack(spacing: 0) {
                ToDoList(isDetailViewPresented: $isDetailViewPresented)
                Divider()
                    .opacity(0)
                    .frame(width: 10)
                    .background(Color(UIColor.systemGray3))
                ToDoList(isDetailViewPresented: $isDetailViewPresented)
                Divider()
                    .opacity(0)
                    .frame(width: 10)
                    .background(Color(UIColor.systemGray3))
                ToDoList(isDetailViewPresented: $isDetailViewPresented)
            }
            .background(Color(UIColor.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
