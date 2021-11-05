//
//  ContentView.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/01.
//

import SwiftUI

struct ContentView: View {
    @State private var isModalViewPresented: Bool = false
    var body: some View {
        NavigationView {
            HStack {
                ProjectListView(type: .todo)
                Divider().frame(width: 10)
                    .background(Color.gray)
                ProjectListView(type: .doing)
                Divider().frame(width: 10)
                    .background(Color.gray)
                ProjectListView(type: .done)
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isModalViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $isModalViewPresented) {
                        ModalView(isDone: $isModalViewPresented,
                                  modalViewType: .add,
                                  currentProject: nil)
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
