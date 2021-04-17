import UIKit


class DataSource {
    static let shared = DataSource()
    
    var things: [Thing] = []
    
    var thingsTodo = [Thing]()
    var thingsDoing = [Thing]()
    var thingsDone = [Thing]()
    
    private init() {
        fetchDataFromAsset()
        configureTodoByState(things: things)
    }
    
    private func configureTodoByState(things: [Thing]) {
        thingsTodo = things.filter { $0.state == .todo }
        thingsDoing = things.filter { $0.state == .doing }
        thingsDone = things.filter { $0.state == .done }
    }
    
    private func fetchDataFromAsset() {
        let decoder = JSONDecoder()
        let dataAsset = NSDataAsset(name: "GET", bundle: .main)
        guard let data = dataAsset?.data else {
            return
        }
        
        do {
            let things = try decoder.decode([Thing].self, from: data)
            self.things = things
        } catch {
            print("\(error)")
        }
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
