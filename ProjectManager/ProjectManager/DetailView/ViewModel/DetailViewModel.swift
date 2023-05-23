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

import Foundation

final class DetailViewModel {
    @Published var title: String = ""
    @Published var body: String = ""
    
    lazy var isEditingDone: AnyPublisher<Bool, Never> = Publishers.CombineLatest($title, $body)
        .map { title, body in
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    let detailService = DetailService()
}
