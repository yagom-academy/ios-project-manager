//
//  ContentView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TodoViewModel()
    @State private var showModal = false
    
    var body: some View {
        NavigationStack{
            HStack{
                SwiftUIList(formCase: .TODO, models: viewModel.todoList)
                SwiftUIList(formCase: .DOING, models: viewModel.doingList)
                SwiftUIList(formCase: .DONE, models: viewModel.doneList)
            }
            .background(Color(UIColor.systemGray4))
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $showModal) {
                ModalView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
