//
//  MemoHomeView.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import SwiftUI

struct MemoHomeView: View {
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorSet.navigationBarBackground.edgesIgnoringSafeArea(.all)
                ColorSet.backgroundBetweenLists
                
                HStack(spacing: 4) {
                    ForEach(Memo.Category.allCases, id: \.description) {
                        MemoListView(category: $0)
                    }
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
        MemoHomeView()
    }
}
