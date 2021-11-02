//
//  ContentView.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MemoViewModel()
    @State var isEdited = false

    var body: some View {
        NavigationView {
            HStack(
                alignment: .center,
                spacing: UIStyle.minInsetAmount
            ) {
                ForEach(Memo.State.allCases) {
                    MemoList(
                        viewModel: viewModel,
                        state: $0,
                        onTap: {
                            isEdited.toggle()
                        },
                        onLongPress: {
                            print("longPress")
                        }
                    )
                        .backgroundColor(.basic)
                }
            }
            .backgroundColor(
                .myGray
            )
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdited.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(
            isPresented: $isEdited,
            onDismiss: {
                // TODO: - when sheet is closed
            },
            content: {
                MemoView(isEdited: $isEdited)
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
