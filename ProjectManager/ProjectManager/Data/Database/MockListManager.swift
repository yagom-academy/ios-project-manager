import Foundation

struct MockListManager: DataRepository {
    
    var list: [Listable] = []
    
    func creatProject(attributes: [String : Any]) -> Listable {
        <#code#>
    }
    
    func readProject(index: IndexPath) -> Listable {
        <#code#>
    }
    
    func updateProject(to subject: Listable, how attributes: [String : Any]) -> Listable {
        <#code#>
    }
    
    func deleteProject(index: IndexPath) {
        <#code#>
    }
    
    func fetch() {
        <#code#>
    }
}
