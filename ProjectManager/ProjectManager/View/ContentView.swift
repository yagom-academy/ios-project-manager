//
//  ContentView.swift
//  ProjectManager
//
//  Created by yun on 2021/10/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text("ProjectManager")
                    .padding(.leading, 30)
                Spacer()
                Button {
                    viewModel.isPresented = true
                } label: {
                    TodoListImageButton(imageName: "plus")
                        .padding(.trailing)
                }
            }
            
            HStack {
                TodoList()
                DoingList()
                DoneList()
            }
        }
        .sheet(isPresented: $viewModel.isPresented) {
            AddItemView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
