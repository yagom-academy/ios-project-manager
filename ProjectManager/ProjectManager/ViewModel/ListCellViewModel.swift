//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/17.
//

import Foundation

class ListCellViewModel {
    var work: Work? {
        didSet {
            cellHandler?(work!)
        }
    }
    
    private var cellHandler: ((Work?) -> Void)?
    
    func bind(handler: @escaping (Work?) -> Void) {
        cellHandler = handler
    }
}
