import SwiftUI

struct TaskDetailView: View {
    @StateObject var taskDetailViewModel = TaskDetailViewModel()
    @Binding var isShowTaskDetailView: Bool
    @State var task: Task = Task(title: "", description: "", deadline: Date())
    
    var body: some View {
        VStack {
            TaskDetailHeaderView(
                taskDetailViewModel: taskDetailViewModel,
                task: $task,
                isShowTaskDetailView: $isShowTaskDetailView
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

struct TaskDetailHeaderView: View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    @Binding var task: Task
    @Binding var isShowTaskDetailView: Bool
    
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
                task: $task,
                isShowTaskDetailView: $isShowTaskDetailView
            )
        }
        .padding(10)
    }
}

struct TaskDetailLeadingButton: View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        Button(action: {
            if taskDetailViewModel.isEditing {
                taskDetailViewModel.changeMode(.edit)
            } else {
                isShowTaskDetailView = false
            }
        }, label: {
            taskDetailViewModel.isEditing ? Text("Edit") : Text("Cancel")
        })
    }
}

struct TaskDetailTitleView: View {
    var body: some View {
        Text("TODO")
            .font(.title2)
            .foregroundColor(.black)
            .bold()
    }
}

struct TaskDetailTrailingButton: View {
    @EnvironmentObject var taskListViewModel: TaskListViewModel
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    @Binding var task: Task
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        Button("Done") {
            if taskDetailViewModel.isEditing {
                taskListViewModel.updateTask(
                    id: task.id,
                    title: taskDetailViewModel.title,
                    description: taskDetailViewModel.description,
                    deadline: taskDetailViewModel.deadline)
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
    }
}

struct TaskDetailContentView : View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        VStack {
            TaskDetailTitleTextField(taskDetailViewModel: taskDetailViewModel)
            TaskDetailDeadlineView(taskDetailViewModel: taskDetailViewModel)
            TaskDetailDescriptionTextEditor(taskDetailViewModel: taskDetailViewModel)
        }
    }
}

struct TaskDetailTitleTextField: View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        TextField("Title", text: $taskDetailViewModel.title)
            .multilineTextAlignment(.leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.black)
            .disabled(taskDetailViewModel.isDisabled)
    }
}

struct TaskDetailDeadlineView: View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        DatePicker("deadline", selection: $taskDetailViewModel.deadline, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
            .disabled(taskDetailViewModel.isDisabled)
    }
}

struct TaskDetailDescriptionTextEditor: View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        TextEditor(text: $taskDetailViewModel.description)
            .multilineTextAlignment(.leading)
            .shadow(radius: 1)
            .disabled(taskDetailViewModel.isDisabled)
    }
}
