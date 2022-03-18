import Foundation

struct Project: Listable, Equatable, Codable {
    
    var name: String
    var detail: String
    var deadline: Date
    var identifier: String
    var progressState: String
    
    init(name: String, detail: String, deadline: Date, indentifier: String, progressState: String) {
        self.name = name
        self.detail = detail
        self.deadline = deadline
        self.identifier = indentifier
        self.progressState = progressState
    }
    
    private enum CodingKeys: String, CodingKey {
           case name
           case detail
           case deadline
           case identifier
           case progressState
       }
       
        init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           self.name = try values.decode(String.self, forKey: .name)
           self.detail = try values.decode(String.self, forKey: .detail)
           let dataDouble = try values.decode(Double.self, forKey: .deadline)
           self.deadline = Date(timeIntervalSince1970: dataDouble)
           self.identifier = try values.decode(String.self, forKey: .identifier)
           self.progressState = try values.decode(String.self, forKey: .progressState)
       }
}
