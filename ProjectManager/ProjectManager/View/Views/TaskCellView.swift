//
//  TaskCellView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskCellView: View {
    private let taskLimitDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.locale = Locale(identifier: Locale.current.regionCode!)
        return dateFormatter
    }()
    
    var task: Task
    @State var isLastDay = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.system(size: 28, weight: .semibold, design: .default))
                .foregroundColor(.black)
                .lineLimit(1)
            Text(task.content)
                .font(.title3)
                .foregroundColor(.gray)
                .lineLimit(3)
            Text(task.limitDate, formatter: taskLimitDateFormatter)
                .font(.body)
                .onAppear {
                    if task.limitDate.isLastDay() {
                        isLastDay.toggle()
                    }
                }
        }
    }
    
    func isLastDay(color: Color) {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        if self > startOfDay {
            return true
        } else {
            return false
        }
    }
}
