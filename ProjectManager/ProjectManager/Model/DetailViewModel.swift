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
}

protocol DetailViewModelOutputInterface {
    var event: Event { get }
}

protocol DetailViewModelable: ObservableObject {
    var input: DetailViewModelInputInterface { get }
    var output: DetailViewModelOutputInterface { get }
}

class DetailViewModel: DetailViewModelable {
    var input: DetailViewModelInputInterface { return self }
    var output: DetailViewModelOutputInterface { return self }
    
    var event: Event {
        didSet {
            delegate?.notifyChange()
        }
    }
    
    var delegate: Delegatable?
    
    init(event: Event) {
        self.event = event
    }
}

extension DetailViewModel: DetailViewModelInputInterface {
    func onSaveTitle(title: String) {
        self.event.title = title
    }
    
    func onSaveDescription(description: String) {
        self.event.description = description
    }
    
    func onSaveDate(date: Date) {
        self.event.date = date
    }

}

extension DetailViewModel: DetailViewModelOutputInterface {

}
