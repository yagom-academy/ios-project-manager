import Foundation

final class MemoryRepository {
    private(set) var projects: [Project]
    
    init(projects: [Project] = []) {
        self.projects = projects
    }
}
