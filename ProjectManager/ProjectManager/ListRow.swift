//
//  ListRow.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import SwiftUI

struct ListRow: View {
    
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                Text(task.description)
                Text(task.localizedDate)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(task: TaskViewModel().tasks[0])
    }
}
