//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/10/26.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isPopoverPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Project Manager")
                    .font(.title3)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
                Button {
                    isPopoverPresented = true
                } label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .sheet(isPresented: $isPopoverPresented) {
                    AddTodo(isModalPresented: $isPopoverPresented)
                }
            }
            .background(Color(white: 0.93))
            HStack {
                List {
                    ForEach(listViewModel.todo, id: \.title) {
                        ProjectMangerRow(project: $0)
                    }
                    .onDelete(perform: listViewModel.deleteTask)
                }
                .background(Color("backgroundGray"))
                List {
                    ForEach(listViewModel.doing, id: \.title) {
                        ProjectMangerRow(project: $0)
                    }
                    .onDelete(perform: listViewModel.deleteTask)
                }
                .background(Color("backgroundGray"))
                List {
                    ForEach(listViewModel.done, id: \.title) {
                        ProjectMangerRow(project: $0)
                    }
                    .onDelete(perform: listViewModel.deleteTask)
                }
                .background(Color("backgroundGray"))
            }
            .background(Color(white: 0.8))
            .listStyle(PlainListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .environmentObject(ListViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
