import Foundation

class TaskDetailViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var deadline = Date()
    
    @Published var isDisabled = false
    @Published var isEditing = false
}
