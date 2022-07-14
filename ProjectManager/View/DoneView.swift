//
//  DoneView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct DoneView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: headerView) {
                    ForEach(contentViewModel.doneTasks) { task in
                        if let index = contentViewModel.doneTasks.firstIndex(of: task) {
                            CellView(contentViewModel: contentViewModel, cellIndex: index)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .listStyle(.grouped)
        }
    }
    
    var headerView: some View {
        HStack {
            Text(TaskType.done.title)
                .font(.largeTitle)
                .foregroundColor(.black)
            ZStack {
            Circle()
                .frame(width: 25, height: 25)
                Text(String(contentViewModel.doneTasks.count))
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
    
    func delete(at offset: IndexSet) {
        contentViewModel.doneTasks.remove(atOffsets: offset)
    }
}

struct DoneView_Previews: PreviewProvider {
    static var previews: some View {
        DoneView(contentViewModel: ContentViewModel()).previewLayout(.sizeThatFits)
    }
}
