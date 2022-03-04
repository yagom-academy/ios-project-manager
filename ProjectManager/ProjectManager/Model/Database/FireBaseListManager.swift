import Foundation

final class FireBaseListManger: ListManager {
    
    var list: [Listable] = [] 
    
    func creatProject(attributes: [String : [Any]]) -> Listable {
        <#code#>
    }
    
    func readProject(index: Int) -> Listable {
        <#code#>
    }
    
    func updateProject(to index: IndexPath, how attributes: [String : Any]) -> Listable {
        <#code#>
    }
    
    func deleteProject(index: IndexPath) {
        <#code#>
    }
    
    func fetch() {
        <#code#>
    }
}
