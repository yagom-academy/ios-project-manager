//
//  ContentView.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var todoTask: [Task] {
        taskViewModel.tasks.filter { task in
            task.state == .todo
        }
    }
    var doingTask: [Task] {
        taskViewModel.tasks.filter { task in
            task.state == .doing
        }
    }
    var doneTask: [Task] {
        taskViewModel.tasks.filter { task in
            task.state == .done
        }
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
