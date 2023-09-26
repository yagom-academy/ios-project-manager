//
//  CardView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var kanbanViewModel: KanbanViewModel
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
                .foregroundColor(
                    cardViewModel.isOverdued &&
                    !kanbanViewModel.dones.contains(where: {
                        $0 == cardViewModel.task
                    }) ? .red : .primary
                )
                
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(task: KanbanViewModel.mock.todos[0])
    }
}
