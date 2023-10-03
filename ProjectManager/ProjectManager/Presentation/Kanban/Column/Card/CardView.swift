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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(cardViewModel.task.title)
                    .font(.title3)
                    .lineLimit(1)
                Text(cardViewModel.task.content)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                Text(cardViewModel.date)
                    .font(.footnote)
                    .foregroundColor(cardViewModel.isOverdue ? .red : .primary)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 0))
        .contextMenu {
            let firstDestination = cardViewModel.firstDestination
            let secondDestination = cardViewModel.secondDestination
                
            Button("Move to \(firstDestination.title)") {
                kanbanViewModel.move(cardViewModel.task, to: firstDestination)
            }
            Button("Move to \(secondDestination.title)") {
                kanbanViewModel.move(cardViewModel.task, to: secondDestination)
            }            
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button("Delete", role: .destructive) {
                kanbanViewModel.delete(cardViewModel.task)
            }
        }
        .onTapGesture {
            kanbanViewModel.setFormVisible(cardViewModel.task)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(task: KanbanViewModel.mock.todos[0])
    }
}
