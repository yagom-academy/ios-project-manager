//
//  MemoHome.swift
//  ProjectManager
//
//  Created by Yena on 2023/09/22.
//

import SwiftUI

struct MemoHome: View {
    @EnvironmentObject var modelData: ModelData
    let background = CustomColor.lightGray
    let backgroundBetweenLists = CustomColor.darkGray
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                backgroundBetweenLists
                
                HStack {
                    ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                        MemoListView(memos: modelData.categories[key]!)
                    }
                }
                .clipped()
                .navigationBarTitle("Project Manager")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    enum CustomColor {
        static let lightGray = Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255)
        static let darkGray = Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)
        static let gray = Color(red: 222 / 255, green: 222 / 255, blue: 226 / 255)
    }
}

struct MemoHome_Previews: PreviewProvider {
    static var previews: some View {
        MemoHome()
            .environmentObject(ModelData())
    }
}
