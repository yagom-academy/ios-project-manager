import Foundation

protocol UseCase {
    
    var repository: DataRepository? { get }
    func createProject()
    func readProject()
    func updateProject()
    func deleteProject()
}
