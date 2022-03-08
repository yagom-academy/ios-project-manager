import XCTest

class ProjectManagerTests: XCTestCase {
    func test_비어있는_TaskRepository에서_TaskListViewModel의_1을_create하면_Task배열은_1이된다() {
        let taskRepository = TaskRepository(entireTasks: [])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        taskListViewModel.create(task: task1)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1])
        XCTAssertEqual(taskRepository.todoTasks,
                       [task1])
    }
    
    func test_1과2가있는_TaskRepository에서_TaskListViewModel의_3을_create하면_Task배열은_123이된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [task1, task2])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        
        let task3 = Task(title: "3", body: "3", dueDate: Date())
        taskListViewModel.create(task: task3)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1, task2, task3])
        XCTAssertEqual(taskRepository.todoTasks,
                       [task1, task2, task3])
    }
    
    func test_1과2가있는_TaskRepository에서_TaskListViewModel의_2를_delete하면_Task배열은_1이된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [task1, task2])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        taskListViewModel.todoTasksObservable.value = [task1, task2]
        
        taskListViewModel.delete(task: task2)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1])
        XCTAssertEqual(taskRepository.todoTasks,
                       [task1])
    }
    
    func test_1과2가있는_TaskRepository에서_TaskListViewModel의_2의title을_update하면_title이변경된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [task1, task2])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        taskListViewModel.todoTasksObservable.value = [task1, task2]
        
        taskListViewModel.update(task: task2, newTitle: "changed", newBody: task2.body, newDueDate: task2.dueDate, newProcessStatus: task2.processStatus)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value[1].title,
                       "changed")
        XCTAssertEqual(taskRepository.todoTasks[1].title,
                       "changed")
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1, task2])
        XCTAssertEqual(taskRepository.todoTasks,
                       [task1, task2])
    }
    
    func test_1과2가있는_TaskRepository에서_TaskListViewModel의_2의ProcessStatus를_edit하면_변경된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [task1, task2])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        taskListViewModel.todoTasksObservable.value = [task1, task2]
        
        taskListViewModel.edit(task: task2, newProcessStatus: .done) // todo -> done
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value[0],
                       task1)
        XCTAssertEqual(taskRepository.todoTasks[0],
                       task1)
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value.count,
                       1)
        XCTAssertEqual(taskRepository.todoTasks.count,
                       1)

        XCTAssertEqual(taskListViewModel.doneTasksObservable.value[0],
                       task2)
        XCTAssertEqual(taskRepository.doneTasks[0],
                       task2)   
        XCTAssertEqual(taskListViewModel.doneTasksObservable.value,
                       [task2])
        XCTAssertEqual(taskRepository.doneTasks,
                       [task2])
    }
    
    func test_1과2가있는_TaskRepository에서_TaskListViewModel의_2의Title을_edit하면_변경된다() {
        let task1 = Task(title: "1", body: "1", dueDate: Date())
        let task2 = Task(title: "2", body: "2", dueDate: Date())
        
        let taskRepository = TaskRepository(entireTasks: [task1, task2])
        let taskListViewModel = TaskListViewModel(taskRepository: taskRepository)
        taskListViewModel.todoTasksObservable.value = [task1, task2]
        
        taskListViewModel.edit(task: task2, newTitle: "changed", newBody: task2.body, newDueDate: task2.dueDate)
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value[1].title,
                       "changed")
        XCTAssertEqual(taskRepository.todoTasks[1].title,
                       "changed")
        
        XCTAssertEqual(taskListViewModel.todoTasksObservable.value,
                       [task1, task2])
        XCTAssertEqual(taskRepository.todoTasks,
                       [task1, task2])
    }
}
