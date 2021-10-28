//
//  ContentView.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            ZStack {
                Text("Project Manager")
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .padding()
            }
            HStack {
                ToDoList()
                ToDoList()
                ToDoList()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
