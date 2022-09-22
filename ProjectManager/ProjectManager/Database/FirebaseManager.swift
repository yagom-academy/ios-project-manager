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
        guard let deviceid = UIDevice.current.identifierForVendor?.uuidString else {
            collectioinId = ""
            return
        }
        collectioinId = deviceid
    }
    
    private let database = Firestore.firestore()
    
    func saveWork(_ work: Work) {
        let workData: [String: Any] = [
            "id": work.id,
            "title": work.title,
            "content": work.content,
            "deadline": work.deadline,
            "state": work.state
        ]
        
        database.collection(collectioinId).document(work.id.uuidString).setData(workData)
    }
    
    func deleteWork(id: UUID) {
        database.collection(collectioinId).document(id.uuidString).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
    
    func fetchWork() -> [Work] {
        let firebaseService = FirebaseService()
        var works: [Work] = []
        
        firebaseService.loadData(collectioinId).map {
            $0.compactMap { firebaseService.convert(form: $0) }
        }.subscribe(onNext: {
            works = $0
        }).disposed(by: DisposeBag())
        
        return works
    }
    
    func updateWork() {
        
    }
}
