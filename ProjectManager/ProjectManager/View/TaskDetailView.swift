import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var deadline = Date()
    @State private var isDisabled = false
    @State private var isEditing = false
    
    @Binding var isShowTaskDetailView: Bool
    
    @State var task: Task = Task(title: "", description: "", deadline: Date())
    
    var body: some View {
        VStack {
            TaskDetailHeaderView(
                viewModel: _viewModel,
                title: $title, description: $description,
                deadline: $deadline,
                task: $task,
                isDisabled: $isDisabled,
                isEditing: $isEditing,
                isShowTaskDetailView: $isShowTaskDetailView
            )
            TaskDetailTitleTextField(title: $title, isDisabled: $isDisabled)
            TaskDetaildeadLineView(deadline: $deadline, isDisabled: $isDisabled)
            TaskDetailDescriptionTextEditor(description: $description, isDisabled: $isDisabled)
        }
        .padding(.horizontal)
        .onAppear {
            if task.title != "" {
                isDisabled = true
                title = task.title
                description = task.description
                deadline = Date(timeIntervalSince1970: task.deadline)
            }
        }
    }
}

struct TaskDetailHeaderView: View {
    @EnvironmentObject var viewModel: TaskListViewModel
    
    @Binding var title: String
    @Binding var description: String
    @Binding var deadline: Date
    
    @Binding var task: Task
    @Binding var isDisabled: Bool
    @Binding var isEditing: Bool
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        HStack {
            TaskDetailLeadingButton(
                isDisabled: $isDisabled,
                isEditing: $isEditing,
                isShowTaskDetailView: $isShowTaskDetailView,
                isEditMode: task.title.isEmpty
            )
            Spacer()
            TaskDetailTitleView()
            Spacer()
            TaskDetailTrailingButton(
                title: $title,
                description: $description,
                deadline: $deadline,
                task: $task,
                isEditing: $isEditing,
                isShowTaskDetailView: $isShowTaskDetailView
            )
        }
        .padding(10)
    }
}

struct TaskDetailLeadingButton: View {
    @Binding var isDisabled: Bool
    @Binding var isEditing: Bool
    @Binding var isShowTaskDetailView: Bool
    let isEditMode: Bool
    
    var body: some View {
        Button(action: {
            if isEditMode {
                isShowTaskDetailView = false
            } else {
                self.isDisabled = false
                self.isEditing = true
            }
        }, label: {
            isEditMode ? Text("Cancel") : Text("Edit")
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
    
    @Binding var title: String
    @Binding var description: String
    @Binding var deadline: Date
    
    @Binding var task: Task
    @Binding var isEditing: Bool
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        Button("Done") {
            if isEditing {
                viewModel.updateTask(id: task.id, title: title, description: description, deadline: deadline)
            } else {
                let task = Task(title: title, description: description, deadline: deadline)
                viewModel.createTask(task)
            }
            isShowTaskDetailView = false
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
            .lineLimit(10)
            .foregroundColor(.black)
            .shadow(radius: 1)
            .disabled(isDisabled)
    }
}
