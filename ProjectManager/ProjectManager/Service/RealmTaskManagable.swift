import Foundation

protocol RealmTaskManagable {
    var taskList: [Task] { get set }
    
    func fetchRealmTaskList()
    func createRealmTask(_ task: Task)
    func updateRealmTask(id: String, title: String, description: String, deadline: Date)
    func updateRealmTaskState(id: String, progressStatus: Task.ProgressStatus)
    func deleteRealmTask(_ id: String)
}
