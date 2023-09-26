//
//  CardView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject private var kanbanViewModel: KanbanViewModel
    private let cardViewModel: CardViewModel
    
    init(task: Task) {
        self.cardViewModel = CardViewModel(task: task)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(cardViewModel.task.title)
                .font(.title3)
                .lineLimit(1)
            Text(cardViewModel.task.content)
                .foregroundColor(.secondary)
                .lineLimit(3)
            Text(cardViewModel.date)
                .font(.footnote)
                .foregroundColor(cardViewModel.isOverdued ? .red : .primary)
        }
        .contextMenu {
            switch cardViewModel.task.state {
            case .todo:
                Button("Move to DOING"){ kanbanViewModel.move(cardViewModel.task, to: .doing) }
                Button("Move to DONE"){ kanbanViewModel.move(cardViewModel.task, to: .done) }
            case .doing:
                Button("Move to TODO"){ kanbanViewModel.move(cardViewModel.task, to: .todo) }
                Button("Move to DONE"){ kanbanViewModel.move(cardViewModel.task, to: .done) }
            case .done:
                Button("Move to TODO"){ kanbanViewModel.move(cardViewModel.task, to: .todo) }
                Button("Move to DOING"){ kanbanViewModel.move(cardViewModel.task, to: .doing) }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(task: KanbanViewModel.mock.todos[0])
    }
}
