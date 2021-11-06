//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/04.
//

import Foundation
import SwiftUI

protocol DetailViewModelInputInterface {
    func onSaveTitle(title: String)
    func onSaveDescription(description: String)
    func onTouchCancel()
}

protocol DetailViewModelOutputInterface {
    var event: Event { get }
}

protocol DetailViewModelable: ObservableObject {
    var input: DetailViewModelInputInterface { get }
    var output: DetailViewModelOutputInterface { get }
}

class DetailViewModel: DetailViewModelable, Identifiable {
    var input: DetailViewModelInputInterface { return self }
    var output: DetailViewModelOutputInterface { return self }
    
    @Published var event: Event
    var isCancelled: Bool = false
    var id: UUID = UUID()
    
    init(event: Event) {
        self.event = event
    }
}

extension DetailViewModel: DetailViewModelInputInterface {
    func onSaveTitle(title: String) {
        self.event.title = title
     //   objectWillChange.send()
    }
    
    func onSaveDescription(description: String) {
        self.event.description = description
     //   objectWillChange.send()
    }
    
    func onSaveDate(date: Date) {
        self.event.date = date
     //   objectWillChange.send()
    }
    
    func onTouchCancel() {
        self.isCancelled = true
    }
}

extension DetailViewModel: DetailViewModelOutputInterface {

}
