//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/18.
//

import Foundation

final class ListViewModel {
    var categoryCount: Int? {
        didSet {
            countHandler?(categoryCount)
        }
    }
    
    private var countHandler: ((Int?) -> Void)?
    
    func bindCount(handler: @escaping (Int?) -> Void) {
        countHandler = handler
    }
}
