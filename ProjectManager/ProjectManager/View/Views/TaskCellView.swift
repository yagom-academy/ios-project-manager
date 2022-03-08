//
//  TaskCellView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskCellView: View {
    let taskLimitDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "Ko_Kr")
        return dateFormatter
    }()
    
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.system(size: 28, weight: .semibold, design: .default))
            Text(task.content)
                .font(.title3)
                .foregroundColor(.gray)
            Text(task.limitDate, formatter: taskLimitDateFormatter)
                .font(.body)
        }
    }
}
