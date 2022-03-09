import SwiftUI

struct TaskDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TaskListViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var deadline = Date()
    @State private var isdisabled = false
    @State private var isEditing = false
    
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
    
    var headerView: some View {
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
    
    var leadingButton: some View {
        Button(action: {
            if task.title.isEmpty {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                self.isdisabled = false
                self.isEditing = true
            }
        }, label: {
            task.title.isEmpty ? Text("Cancel") : Text("Edit")
        })
    }
    
    var trailingButton: some View {
        Button("Done") {
            if isEditing {
                viewModel.updateTask(task, title: title, description: description, deadline: deadline)
            } else {
                let task = Task(title: title, description: description, deadline: deadline)
                viewModel.createTask(task)
            }
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var titleTextField: some View {
        TextField(task.title, text: $title)
            .multilineTextAlignment(.leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.black)
            .disabled(isdisabled)
    }
    
    var deadLineView: some View {
        DatePicker("deadline", selection: $deadline, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
            .disabled(isdisabled)
    }
    
    var descriptionTextEditor: some View {
        TextEditor(text: $description)
            .multilineTextAlignment(.leading)
            .lineLimit(10)
            .foregroundColor(.black)
            .shadow(radius: 1)
            .disabled(isdisabled)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(title: "", description: "", deadline: Date()))
    }
}
