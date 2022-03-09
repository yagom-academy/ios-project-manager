import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    let progressStatus: ProgressStatus
    
    var taskList: [Task] {
        switch progressStatus {
        case .todo:
            return viewModel.todoTaskList
        case .doing:
            return viewModel.doingTaskList
        case .done:
            return viewModel.doneTaskList
        }
    }
    
    var body: some View {
        VStack {
            title
            listView
        }
    }
    
    private var title: some View {
        HStack {
            Text("\(progressStatus.name)")
                .font(.title2)
                .padding(.leading)
            Spacer()
            Text("\(taskList.count)")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var listView: some View {
        List {
            ForEach(taskList) { task in
                TaskListCellView(task: task)
            }
            .onDelete { indexSet in
                viewModel.deleteTask(taskList[indexSet.index])
            }
        }
    }
}
