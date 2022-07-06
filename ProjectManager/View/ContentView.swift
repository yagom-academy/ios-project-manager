//
//  ContentView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    var body: some View {
        
        NavigationView {
            HStack {
                VStack(alignment: .leading) {
                        List {
                            Section(header: TodoView()){
                                Button {
                                    showSheet.toggle()
                                } label: {
                                    ListRowView()
                                }
                                .sheet(isPresented: $showSheet) {
                                    RegisterView()
                                }
                            }
                        }
                        .listStyle(.grouped)
                }
                
                VStack(alignment: .leading) {
                    List {
                        Section(header: DoingView()) {
                            ListRowView()
                        }
                    }
                    .listStyle(.grouped)
                }
                
                VStack(alignment: .leading) {
                    List {
                        Section(header: DoneView()) {
                            ListRowView()
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
                        RegisterView()
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
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
