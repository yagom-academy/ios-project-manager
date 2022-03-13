import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
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
            TaskDetailContentView(
                taskDetailViewModel: taskDetailViewModel
            )
        }
        .padding(.horizontal)
        .onAppear {
            if task.title != "" {
                taskDetailViewModel.isDisabled = true
                taskDetailViewModel.title = task.title
                taskDetailViewModel.description = task.description
                taskDetailViewModel.deadline = Date(timeIntervalSince1970: task.deadline)
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
                isShowTaskDetailView: $isShowTaskDetailView,
                isEditMode: !task.title.isEmpty
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
    let isEditMode: Bool
    
    var body: some View {
        Button(action: {
            if isEditMode {
                taskDetailViewModel.isDisabled = false
                taskDetailViewModel.isEditing = true
            } else {
                isShowTaskDetailView = false
            }
        }, label: {
            isEditMode ? Text("Edit") : Text("Cancel")
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
    @EnvironmentObject var viewModel: TaskListViewModel
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    @Binding var task: Task
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        Button("Done") {
            if taskDetailViewModel.isEditing {
                viewModel.updateTask(
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
                viewModel.createTask(task)
            }
            isShowTaskDetailView = false
        }
    }
}

struct TaskDetailContentView : View {
    @ObservedObject var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        VStack {
            TaskDetailTitleTextField(
                title: $taskDetailViewModel.title,
                isDisabled: $taskDetailViewModel.isDisabled
            )
            TaskDetaildeadLineView(
                deadline: $taskDetailViewModel.deadline,
                isDisabled: $taskDetailViewModel.isDisabled
            )
            TaskDetailDescriptionTextEditor(
                description: $taskDetailViewModel.description,
                isDisabled: $taskDetailViewModel.isDisabled
            )
        }
    }
}

struct TaskDetailTitleTextField: View {
    @Binding var title: String
    @Binding var isDisabled: Bool
    
    var body: some View {
        TextField("Title", text: $title)
            .multilineTextAlignment(.leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.black)
            .disabled(isDisabled)
    }
}

struct TaskDetaildeadLineView: View {
    @Binding var deadline: Date
    @Binding var isDisabled: Bool
    
    var body: some View {
        DatePicker("deadline", selection: $deadline, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
            .disabled(isDisabled)
    }
}

struct TaskDetailDescriptionTextEditor: View {
    @Binding var description: String
    @Binding var isDisabled: Bool
    
    var body: some View {
        TextEditor(text: $description)
            .multilineTextAlignment(.leading)
            .shadow(radius: 1)
            .disabled(isDisabled)
    }
}
