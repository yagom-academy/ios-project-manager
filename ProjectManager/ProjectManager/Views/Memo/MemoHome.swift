//
//  MemoHome.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorSet.navigationBarBackground.edgesIgnoringSafeArea(.all)
                ColorSet.backgroundBetweenLists
                
                HStack {
                    MemoListView(memos: modelData.toDoList, category: .toDo)
                    MemoListView(memos: modelData.doingList, category: .doing)
                    MemoListView(memos: modelData.doneList, category: .done)
                }
                .clipped()
                .navigationBarTitle("Project Manager")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing:
                        Button {
                            showDetail.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showDetail) {
                            NewMemo()
                        }
                )
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoHome_Previews: PreviewProvider {
    static var previews: some View {
        MemoHome()
            .environmentObject(ModelData())
    }
}
