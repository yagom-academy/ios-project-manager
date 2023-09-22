//
//  CardView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/22.
//

import SwiftUI

struct CardView: View {
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(task.title)")
                .font(.title3)
                .lineLimit(1)
            Text("\(task.content)")
                .foregroundColor(.secondary)
                .lineLimit(3)
            Text("\(task.date.formatted(date: .numeric, time: .omitted))")
                .font(.footnote)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(task: KanbanViewModel.mock.todos[0])
    }
}
