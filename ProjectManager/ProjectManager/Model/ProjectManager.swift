//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

// MARK: - DataSourceType
enum DataSourceType {
    
    case inMemory
    case coreData
    case firestore
    
    var userDescription: String {
        switch self {
        case .inMemory:
            return "휘발성"
        case .coreData:
            return "앱"
        case .firestore:
            return "Cloud"
        }
    }
}

// MARK: - NetworkStatus
enum NetworkStatus {
    
    case online
    case offline
    
}

// MARK: - ProjectManagerDelegate
protocol ProjectManagerDelegate: AnyObject {
    
    func projectManager(didChangedDataSource dataSource: DataSourceType)
    
    func projectManager(didChangedNetworkStatus with: NetworkStatus)
}

// MARK: - ProjectManager
final class ProjectManager {
    
    // MARK: - Property
    weak var delegate: ProjectManagerDelegate?
    private var projectSource: DataSource? = ProjectCoreDataManager()
    private (set) var projectSourceType: DataSourceType? {
        get {
            return self.projectSource?.type
        }
        set
        {
            switch newValue {
            case .coreData:
                self.projectSource = ProjectCoreDataManager()
            case .firestore:
                self.projectSource = ProjectFirestoreManager()
            case .inMemory, .none:
                self.projectSource = ProjectInMemoryManager()
            }
        }
    }
    
    // MARK: - Method
    func create(with content: [String: Any]) {
        self.projectSource?.create(with: content)
    }
    
    func readProject(
        of identifier: String,
        completion: @escaping (Result<Project?, Error>
        ) -> Void) {
        self.projectSource?.read(of: identifier, completion: completion)
    }
    
    func readProject(
        of status: Status,
        completion: @escaping (Result<[Project]?, Error>
    ) -> Void)  {
        self.projectSource?.read(of: status, completion: completion)
    }
    
    func updateProjectContent(of identifier: String, with content: [String: Any]) {
        self.projectSource?.updateContent(of: identifier, with: content)
    }
    
    func updateProjectStatus(of identifier: String, with status: Status) {
        self.projectSource?.updateStatus(of: identifier, with: status)
    }
    
    func delete(of identifier: String) {
        self.projectSource?.delete(of: identifier)
    }
    
    func switchProjectSource(with dataSource: DataSourceType) {
        self.projectSourceType = dataSource
        self.delegate?.projectManager(didChangedDataSource: dataSource)
    }
}
