//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import Combine

/*
 DetailViewModel
 컨트롤러에서 입력시
    DetailService 주입.
    let title: String <-
    let textView: String <-
 
    // DetailService 갖고있어야하고
    // DetailService는 Repository도 갖고있어야함.
 */

final class DetailViewModel {
    struct Input {
        let title: AnyPublisher<String, Never>
        let date: AnyPublisher<String, Never>
        let body: AnyPublisher<String, Never>
    }
    
    
    let detailService = DetailService()
    
    
}
