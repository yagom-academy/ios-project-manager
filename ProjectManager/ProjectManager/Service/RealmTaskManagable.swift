import Foundation

protocol RealmTaskManagable {
    var taskList: [Task] { get set }
    
    func fetchRealmTaskList() throws
    func createRealmTask(_ task: Task) throws
    func updateRealmTask(id: String, title: String, description: String, deadline: Date) throws
    func updateRealmTaskStatus(id: String, progressStatus: Task.ProgressStatus) throws
    func deleteRealmTask(_ id: String) throws
}
