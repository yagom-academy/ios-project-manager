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
    var title: String = ""
    var date: Date = Date()
    var body: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let title: AnyPublisher<String, Never>
        let date: AnyPublisher<Date, Never>
        let body: AnyPublisher<String, Never>
    }
    
    let detailService = DetailService()
    
    func transform(input: Input) {
        input.title
            .assign(to: \.title, on: self)
            .store(in: &cancellables)
        
        input.date
            .assign(to: \.date, on: self)
            .store(in: &cancellables)
        
        input.body
            .assign(to: \.body, on: self)
            .store(in: &cancellables)
    }
}
