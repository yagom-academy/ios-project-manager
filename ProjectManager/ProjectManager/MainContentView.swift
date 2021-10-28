//
//  ContentView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/26.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        HStack {
            ForEach(Todo.Completion.allCases, id: \.self) { eachCase in
                TodoList(completionState: eachCase)
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
