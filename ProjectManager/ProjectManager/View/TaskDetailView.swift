import SwiftUI

struct TaskDetailView: View {
    @StateObject var taskDetailViewModel = TaskDetailViewModel()
    @Binding var isShowTaskDetailView: Bool
    @State var task: Task = Task(title: "", description: "", deadline: Date())
    
    var body: some View {
        VStack {
            TaskDetailHeaderView(
                taskDetailViewModel: taskDetailViewModel,
                isShowTaskDetailView: $isShowTaskDetailView,
                task: $task
            )
            TaskDetailContentView(taskDetailViewModel: taskDetailViewModel)
        }
        .padding(.horizontal)
        .onAppear {
            if !task.title.isEmpty {
                taskDetailViewModel.changeMode(.read)
                taskDetailViewModel.fillTaskDetail(
                    title: task.title,
                    description: task.description,
                    deadline: task.deadline
                )
            }
        }
    }
}

private struct TaskDetailHeaderView: View {
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    @Binding fileprivate var isShowTaskDetailView: Bool
    @Binding fileprivate var task: Task
    
    var body: some View {
        HStack {
            TaskDetailLeadingButton(
                taskDetailViewModel: taskDetailViewModel,
                isShowTaskDetailView: $isShowTaskDetailView
            )
            Spacer()
            TaskDetailTitleView()
            Spacer()
            TaskDetailTrailingButton(
                taskDetailViewModel: taskDetailViewModel,
                isShowTaskDetailView: $isShowTaskDetailView,
                task: $task
            )
        }
        .padding(10)
    }
}

private struct TaskDetailLeadingButton: View {
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    @Binding fileprivate var isShowTaskDetailView: Bool
    
    var body: some View {
        Button(action: {
            if taskDetailViewModel.isEditing {
                taskDetailViewModel.changeMode(.edit)
            } else {
                isShowTaskDetailView = false
            }
        }, label: {
            taskDetailViewModel.isEditing ? Text("Edit".localized()) : Text("Cancel".localized())
        })
    }
}

private struct TaskDetailTitleView: View {
    var body: some View {
        Text("TODO")
            .font(.title2)
            .foregroundColor(.black)
            .bold()
    }
}

private struct TaskDetailTrailingButton: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    @Binding fileprivate var isShowTaskDetailView: Bool
    @Binding fileprivate var task: Task
    
    var body: some View {
        Button("Done".localized()) {
            if taskDetailViewModel.isEditing {
                taskListViewModel.updateTask(
                    id: task.id,
                    title: taskDetailViewModel.title,
                    description: taskDetailViewModel.description,
                    deadline: taskDetailViewModel.deadline
                )
            } else {
                let task = Task(
                    title: taskDetailViewModel.title,
                    description: taskDetailViewModel.description,
                    deadline: taskDetailViewModel.deadline
                )
                taskListViewModel.createTask(task)
            }
            isShowTaskDetailView = false
        }
        .alert(item: $taskListViewModel.errorAlert) { error in
            Alert(title: Text("Error".localized()), message: Text(error.message))
        }
    }
}

private struct TaskDetailContentView : View {
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        VStack {
            TaskDetailTitleTextField(taskDetailViewModel: taskDetailViewModel)
            TaskDetailDeadlineView(taskDetailViewModel: taskDetailViewModel)
            TaskDetailDescriptionTextEditor(taskDetailViewModel: taskDetailViewModel)
        }
    }
}

private struct TaskDetailTitleTextField: View {
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        TextField("Title", text: $taskDetailViewModel.title)
            .multilineTextAlignment(.leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.black)
            .disabled(taskDetailViewModel.isDisabled)
    }
}

private struct TaskDetailDeadlineView: View {
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        DatePicker("deadline", selection: $taskDetailViewModel.deadline, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
            .disabled(taskDetailViewModel.isDisabled)
    }
}

private struct TaskDetailDescriptionTextEditor: View {
    @ObservedObject fileprivate var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        TextEditor(text: $taskDetailViewModel.description)
            .multilineTextAlignment(.leading)
            .shadow(radius: 1)
            .disabled(taskDetailViewModel.isDisabled)
    }
}
