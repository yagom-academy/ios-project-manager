import Foundation

final class ProjectViewModel {
    var project: Observable<Project>
    
    init(project: Project) {
        self.project = Observable(project)
    }
}
