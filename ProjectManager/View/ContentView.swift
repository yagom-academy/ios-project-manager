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
    
    var body: some View {
        
        NavigationView {
            HStack {
                VStack(alignment: .leading) {
                    List {
                        Section(header: TodoView()){
                            ForEach(contentViewModel.todoTasks) { _ in
                                CellView(contentViewModel: contentViewModel)
                            }
                            .onDelete(perform: delete)
                        }
                    }
                    .listStyle(.grouped)
                }
                
                VStack(alignment: .leading) {
                    List {
                        Section(header: DoingView()) {
                            ForEach(contentViewModel.doingTasks) { _ in
                                CellView(contentViewModel: contentViewModel)
                            }
                            .onDelete(perform: delete)
                        }
                    }
                    .listStyle(.grouped)
                }
                
                VStack(alignment: .leading) {
                    List {
                        Section(header: DoneView()) {
                            ForEach(contentViewModel.doneTasks) { _ in
                                CellView(contentViewModel: contentViewModel)
                            }
                            .onDelete(perform: delete)
                        }
                    }
                    .listStyle(.grouped)
                }
            }
            .background(.gray)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("plusbutton")
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
    
    func delete(at offset: IndexSet) {
        contentViewModel.todoTasks.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
