//
//  ContentView.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 6
        ) {
            Spacer(minLength: 50)
            MemoList(title: "TODO")
            MemoList(title: "DOING")
            MemoList(title: "DONE")
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
