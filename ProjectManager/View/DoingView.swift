//
//  DoingView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct DoingView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: headerView) {
                    ForEach(contentViewModel.doingTasks) { task in
                        if let index = contentViewModel.doingTasks.firstIndex(of: task) {
                            CellView(contentViewModel: contentViewModel, cellIndex: index, taskType: .doing)
                        }
                    }
                    .onDelete { offset in
                        contentViewModel.doingTasks.remove(atOffsets: offset)
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
    
    var headerView: some View {
        HStack {
            Text(TaskType.doing.title)
                .font(.largeTitle)
                .foregroundColor(.black)
            ZStack {
            Circle()
                .frame(width: 25, height: 25)
                Text(String($contentViewModel.doingTasks.count))
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
}

struct DoingView_Previews: PreviewProvider {
    static var previews: some View {
        DoingView(contentViewModel: ContentViewModel())
    }
}
