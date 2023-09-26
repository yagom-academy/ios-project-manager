//
//  ColumnView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 9/20/23.
//

import SwiftUI

struct ColumnView: View {
    var tasks: [Task]
    let title: String
    
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
