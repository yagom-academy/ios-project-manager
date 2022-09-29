//
//  FirebaseRepository.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/27.
//

import Firebase
import FirebaseDatabase

class FirebaseManager<T: Codable> {
    typealias Entity = T
    
    private let reference: DatabaseReference
    private let rootChildID: String
    
    init(rootChildID: String) {
        self.rootChildID = rootChildID
        let database = Database.database()
        database.isPersistenceEnabled = true
        
        reference = database.reference()
    }
    
    func setValue(childId: String,
                  model: Entity) throws {
        guard let encodedData = try? JSONEncoder().encode(model)
        else { throw FirebaseError.encoding }
        
        guard let jsonData = try? JSONSerialization.jsonObject(with: encodedData)
        else { throw FirebaseError.JSONSerialization}
        
        reference.child(rootChildID).child(childId).setValue(jsonData)
    }
    
    func readAllValue(completionHandler: @escaping((Result<[Entity], FirebaseError>) -> Void)) {
        reference.child(rootChildID).observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let self = self
            else { return }
            
            let dictionary = self.convertDataSnapshot(snapshot)
            let jsondata = self.convertJSONSerialization(with: dictionary)
            let model = self.decode(with: jsondata)
            
            completionHandler(model)
        })
    }
    
    func deleteValue(childId: String) {
        reference.child(rootChildID).child(childId).removeValue()
    }
    
    private func decode(with data: Result<Data, FirebaseError>) -> Result<[Entity], FirebaseError> {
        switch data {
        case .success(let jsonData):
            guard let decodedData = try? JSONDecoder().decode([Entity].self, from: jsonData)
            else { return .failure(.decoding) }
            
            return .success(decodedData)
        case.failure(let error):
            return .failure(error)
        }
    }
    
    private func convertDataSnapshot(_ snapshot: DataSnapshot) -> Result<[String: Any], FirebaseError> {
        guard let dictionary = snapshot.value as? [String: Any]
        else { return .failure(.dataSnapshot) }
        
        return .success(dictionary)
    }
    
    private func convertJSONSerialization(with dictionary: Result<[String: Any], FirebaseError>)
    -> Result<Data, FirebaseError> {
        switch dictionary {
        case .success(let data):
            let values = data.map {
                $0.value
            }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: values)
            else { return .failure(.JSONSerialization) }
            
            return .success(jsonData)
        case .failure(let error):
            return .failure(error)
        }
    }
}
