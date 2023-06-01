//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/06/01.
//

import Combine

final class MainViewModel {
    private let projectManagerService = ProjectManagerService.shared
    
    func isNetworkConnectedPublisher() -> AnyPublisher<Bool, Never> {
        return projectManagerService.isNetworkConnectedPublisher()
    }
}
