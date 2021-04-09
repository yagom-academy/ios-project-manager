import UIKit


class DataSource {
    static let shared = DataSource()
    
    var things: [Thing] = [Thing(id: 1, title: "Self-sizing 고민해보기", description: "Lorem Ipsum is simply dummy text.", state: .todo, dueDate: 0.0, updatedAt: 0.0), Thing(id: 2, title: "DiffableDataSource 공부해보기", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a ty≥pe specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", state: .doing, dueDate: 0.0, updatedAt: 0.0)]
    
    var thingsTodo = [Thing]()
    var thingsDoing = [Thing]()
    var thingsDone = [Thing]()
    
    private init() {
        configureTodoByState(things: things)
    }
    
    private func configureTodoByState(things: [Thing]) {
        thingsTodo = things.filter { $0.state == .todo }
        thingsDoing = things.filter { $0.state == .doing }
        thingsDone = things.filter { $0.state == .done }
    }
    
    func getDataByState(state: State) -> [Thing] {
        switch state {
        case .todo:
            return thingsTodo
        case .doing:
            return thingsDoing
        case .done:
            return thingsDone
        }
    }
}
