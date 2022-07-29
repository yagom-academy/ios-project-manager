//
//  NetworkStorage.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/29.
//

import RxSwift

protocol NetworkStorageProtocol {
    func read() -> Observable<[ProjectDTO]>
    func update(projects: [ProjectDTO])
}

final class NetworkStorage: NetworkStorageProtocol {
    private let networkManger: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManger = networkManager
    }
}

extension NetworkStorage {
    func read() -> Observable<[ProjectDTO]> {
        return networkManger.read()
    }
    
    func update(projects: [ProjectDTO]) {
        networkManger.update(projects: projects)
    }
}
