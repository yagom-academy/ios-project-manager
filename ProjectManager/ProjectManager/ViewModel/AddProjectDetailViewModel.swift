import Foundation

class AddProjectDetailViewModel {
    var currentProject: Project
    var onAppended: ((Project) -> Void)?
    
    init(currentProject: Project) {
        self.currentProject = currentProject
    }
    
    func didTapDoneButton(_ project: Project) {
        onAppended?(project)
    }
}
