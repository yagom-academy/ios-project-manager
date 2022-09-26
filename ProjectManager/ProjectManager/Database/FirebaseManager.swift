//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/22.
//

import RxSwift
import FirebaseFirestore
import Foundation

class FirebaseManager: DatabaseManageable {
    static let shared = FirebaseManager()
    private let collectioinId: String
    
    private init() {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            collectioinId = ""
            return
        }
        collectioinId = deviceId
    }
    
    private let database = Firestore.firestore()
    
    func saveWork(_ work: Work) {
        let workData: [String: Any] = [
            "id": work.id.uuidString,
            "title": work.title,
            "content": work.content,
            "deadline": work.deadline,
            "state": work.state.rawValue
        ]
        
        database.collection(collectioinId).document(work.id.uuidString).setData(workData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func deleteWork(id: UUID) {
        database.collection(collectioinId).document(id.uuidString).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
    
    func fetchWork() -> Observable<[Work]> {
        let firebaseService = FirebaseService()
        
        return firebaseService.loadData(collectioinId).map {
            $0.compactMap { firebaseService.convert(form: $0) }
        }
    }
}
