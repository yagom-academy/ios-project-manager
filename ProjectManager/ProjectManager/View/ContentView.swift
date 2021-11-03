//
//  ContentView.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/01.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationView {
            HStack {
                TodoListView(type: .toDo)
                Divider().frame(width: 10)
                    .background(Color.gray)
                TodoListView(type: .doing)
                Divider().frame(width: 10)
                    .background(Color.gray)
                TodoListView(type: .done)
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $isPresented) {
                        ModalView(isDone: $isPresented, modalViewType: .add)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
