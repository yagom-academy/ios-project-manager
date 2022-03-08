import Foundation

// TODO: Local/Remote BD 구현 시 활용
protocol StorageProtocol {
    func create(task: Task, of processStatus: ProcessStatus)
    func updateTask(of task: Task, title: String, body: String, dueDate: Date)
    func delete(task: Task, of processStatus: ProcessStatus)
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus)
}
