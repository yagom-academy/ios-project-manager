import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var deadline = Date()
    @State private var isdisabled = false
    @State private var isEditing = false
    
    @Binding var isShowTaskDetailView: Bool
    
    var task: Task = Task(title: "", description: "", deadline: Date())
    
    var body: some View {
        VStack {
            headerView
            titleTextField
            deadLineView
            descriptionTextEditor
        }
        .padding(.horizontal)
        .onAppear {
            if task.title != "" {
                isdisabled = true
                title = task.title
                description = task.description
                deadline = Date(timeIntervalSince1970: task.deadline)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            leadingButton
            Spacer()
            Text("TODO")
                .font(.title2)
                .foregroundColor(.black)
                .bold()
            Spacer()
            trailingButton
        }
        .padding(10)
    }
    
    private var leadingButton: some View {
        Button(action: {
            if task.title.isEmpty {
                isShowTaskDetailView = false
            } else {
                self.isdisabled = false
                self.isEditing = true
            }
        }, label: {
            task.title.isEmpty ? Text("Cancel") : Text("Edit")
        })
    }
    
    private var trailingButton: some View {
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
    
    private var titleTextField: some View {
        TextField(task.title, text: $title)
            .multilineTextAlignment(.leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.black)
            .disabled(isdisabled)
    }
    
    private var deadLineView: some View {
        DatePicker("deadline", selection: $deadline, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
            .disabled(isdisabled)
    }
    
    private var descriptionTextEditor: some View {
        TextEditor(text: $description)
            .multilineTextAlignment(.leading)
            .lineLimit(10)
            .foregroundColor(.black)
            .shadow(radius: 1)
            .disabled(isdisabled)
    }
}
