//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListView: View {
    
    @State var tasks: [Task]
    let taskStatus: TaskStatus
    private var taskListHeaderTitle: String {
        switch taskStatus {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text(taskListHeaderTitle)
                    .font(.largeTitle)
                Text(tasks.count / 100 < 1 ? "\(tasks.count)" : "99+")
                    .frame(width: 30, height: 24)
                    .font(.title3)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding(.all, 5)
                    .background(Color.primary)
                    .clipShape(Circle())
                    .minimumScaleFactor(0.8)
                Spacer()
            }
            .padding(EdgeInsets(top: 11, leading: 21, bottom: -1, trailing: 21))
            List {
                ForEach(tasks) { task in
                    TaskListRowView(task: task)
                }
                .onDelete { indexSet in
                    print("💚 할일 삭제 버튼 눌림!") // TODO: 할일 인스턴스 삭제 로직 연결
                    tasks.remove(atOffsets: indexSet)
                    // 캡쳐된 연산 프로퍼티인 tasks 배열 내에서만 삭제되므로, 할일 인스턴스는 완전 삭제되지 않은 상태임
                }
            }
            .listStyle(.plain)
        }
        .background(Color(UIColor.systemGray6))
    }
}
