import Foundation

struct MockListManager: ListManager {
    
    var list: [Listable] = []
    
    func creatProject(attributes: [String : [Any]]) -> Listable {
        <#code#>
    }
    
    func readProject(index: Int) -> Listable {
        <#code#>
    }
    
    func updateProject(to subject: Listable, how attributes: [String : [Any]]) -> Listable {
        <#code#>
    }
    
    func deleteProject(index: Int) {
        <#code#>
    }
    
    func save() {
        <#code#>
    }
}
