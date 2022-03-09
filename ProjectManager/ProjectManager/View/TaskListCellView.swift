import SwiftUI

struct TaskListCellView: View {
    @EnvironmentObject var viewModel: TaskListViewModel
    
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            title
            descrition
            deadline
        }
    }
    
    var title: some View {
        Text(task.title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .lineLimit(1)
    }
    
    var descrition: some View {
        Text(task.description)
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .foregroundColor(.gray)
            .lineLimit(3)
    }
    
    var deadline: some View {
        let deadlineText = Text(task.deadline.formattedDate)
        let currentTime = Date().timeIntervalSince1970
        
        if task.progressStatus != .done, task.deadline < currentTime {
            return deadlineText
                .foregroundColor(Color.red)
                .font(.system(size: 15, weight: .regular, design: .rounded))
        } else {
            return deadlineText
                .font(.system(size: 15, weight: .regular, design: .rounded))
        }
    }
}

struct TaskListCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListCellView(task: Task(title: "title", description: "description", deadline: Date()))
    }
}
