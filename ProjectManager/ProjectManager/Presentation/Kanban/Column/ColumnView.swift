//
//  ColumnView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 9/20/23.
//

import SwiftUI

struct ColumnView: View {
    private let tasks: [Task]
    private let title: String
    
    init(tasks: [Task], title: String) {
        self.tasks = tasks
        self.title = title
    }
    
    var body: some View {
        List {
            Section {
                ForEach(tasks) { task in
                    CardView(task: task)
                }
            } header: {
                HStack {
                    Text(title)
                        .font(.title)
                        .foregroundColor(.primary)
                    Text("\(tasks.count)")
                        .foregroundColor(.white)
                        .bold()
                        .padding(6)
                        .background {
                            Circle().fill(.black)
                        }
                }
            }
        }
        .listStyle(.grouped)
    }
}

struct ColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ColumnView(tasks: KanbanViewModel.mock.todos, title: "TODO")
    }
}
