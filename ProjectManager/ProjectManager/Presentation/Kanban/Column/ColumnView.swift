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
                        .listRowInsets(.init())
                        .alignmentGuide(.listRowSeparatorLeading) { _ in
                            0
                        }
                }
            } header: {
                columnInfo
            }
        }
        .listStyle(.grouped)
    }
    
    private var columnInfo: some View {
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

struct ColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ColumnView(tasks: TaskManager.mock.todos, title: "TODO")
    }
}
