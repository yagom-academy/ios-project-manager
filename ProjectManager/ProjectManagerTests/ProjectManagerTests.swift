import XCTest

class ProjectManagerTests: XCTestCase {
    func test_TaskListViewModel에_새로운Task를_create하면_Task배열에_추가된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [task1, task2])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        
        let task3 = Task(title: "3", body: "3", dueDate: Date())
        taskListViewModel.create(task: task3)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1, task2, task3])
//        XCTAssertEqual(taskRepository.todoTasks,
//                       [task1, task2, task3])
    }
    
    func test_TaskRepository에_새로운Task를_create하면_Task배열에_추가된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        taskListViewModel.todoTasksObservable.value = [task1, task2]
        
        let task3 = Task(title: "3", body: "3", dueDate: Date())
        taskListViewModel.create(task: task3)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1, task2, task3])
//        XCTAssertEqual(taskRepository.todoTasks,
//                       [task1, task2, task3])
    }
}
