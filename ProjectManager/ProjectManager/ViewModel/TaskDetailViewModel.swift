import Foundation

class TaskDetailViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var deadline = Date()
    
    @Published var isDisabled = false
    @Published var isEditing = false
    
    enum DetailViewMode {
        case create
        case read
        case edit
    }
    
    func changeMode(_ mode: DetailViewMode) {
        switch mode {
        case .create:
            isDisabled = false
            isEditing = false
        case .read:
            isDisabled = true
            isEditing = true
        case .edit:
            isDisabled = false
            isEditing = true
        }
    }
    
    func fillTaskDetail(title: String, description: String, deadline: TimeInterval) {
        self.title = title
        self.description = description
        self.deadline = Date(timeIntervalSince1970: deadline)
    }
}
