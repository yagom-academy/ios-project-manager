//
//  CellView.swift
//  ProjectManager
//
//  Created by Whales on 9/20/23.
//

import SwiftUI

struct CellView: View {
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(task.title)")
                .font(.title3)
            Text("\(task.content)")
                .foregroundColor(.secondary)
            Text("\(task.date)")
                .font(.footnote)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(task: Task(title: "제목", content: "내용", date: .now))
    }
}
