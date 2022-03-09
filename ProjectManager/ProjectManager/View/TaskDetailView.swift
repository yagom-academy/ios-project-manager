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
            titleView
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
    
    var titleView: some View {
        HStack {
            if task.title == "" {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                Button("Edit") {
                    self.isdisabled = false
                    self.isEditing = true
                }
            }
            
            Spacer()
            
            Text("TODO")
                .font(.title2)
                .foregroundColor(.black)
                .bold()
            
            Spacer()
            
            if self.isEditing == true {
                Button("Done") {
                    viewModel.updateTask(task, title: title, description: description, deadline: deadline)
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                Button("Done") {
                    let task = Task(title: title, description: description, deadline: deadline)
                    viewModel.createTask(task)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding(10)
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
