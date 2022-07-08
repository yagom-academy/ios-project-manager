//
//  ContentView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @State private var isShowingPopover = false
    
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
                            .onLongPressGesture(minimumDuration: 1) {
                                isShowingPopover.toggle()
                            }
                            .popover(isPresented: $isShowingPopover,
                                     arrowEdge: .bottom) {
                                PopoverButton()
                            }
                            .sheet(isPresented: $showSheet) {
                                RegisterView()
                            }
                            .swipeActions(edge: .trailing,
                                          allowsFullSwipe: true) {
                                SwipeButton()
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

struct PopoverButton: View {
    var body: some View {
        Form {
            Button(action: { print("Move to DOING") }) {
                Text("Move to DOING")
            }
            Button(action: { print("Move to DONE") }) {
                Text("Move to DONE")
            }
        }.frame(width: 190, height: 90, alignment: .center)
    }
}

struct SwipeButton: View {
    var body: some View {
        Button(action: { print("Delete") }) {
            Text("Delete")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
