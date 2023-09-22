//
//  MemoHome.swift
//  ProjectManager
//
//  Created by Yena on 2023/09/22.
//

import SwiftUI

struct MemoHome: View {
    var body: some View {
        NavigationView {
            HStack {
                MemoListView(list: ModelData().toDoList)
                MemoListView(list: ModelData().doingList)
                MemoListView(list: ModelData().doneList)
            }
            .navigationBarTitle("Project Manager")
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoHome_Previews: PreviewProvider {
    static var previews: some View {
        MemoHome()
    }
}
