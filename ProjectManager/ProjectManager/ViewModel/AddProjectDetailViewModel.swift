import Foundation

class AddProjectDetailViewModel {
    var onAppended: ((Project) -> Void)?
    
    func didTapDoneButton(_ project: Project) {
        onAppended?(project)
    }
}
