import Foundation

class EditProjectDetailViewModel {
    var currentProject: Project
    var onUpdated: ((Project) -> Void)?
    
    init(currentProject: Project) {
        self.currentProject = currentProject
    }
    
    func didTapDoneButton(_ project: Project) {
        onUpdated?(project)
    }
}
