//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

final class DetailViewModel {

    private var detailUseCase: DetailUseCase
    private var isEditable: Bool = false {
        didSet {
            editHandler?(isEditable)
        }
    }
    private var isValidText: Bool = true {
        didSet {
            textHandler?(isValidText)
        }
    }
    private var editHandler: ((Bool) -> Void)?
    private var textHandler: ((Bool) -> Void)?

    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }

    func bindEditable(handler: @escaping (Bool) -> Void) {
        editHandler = handler
    }
    
    func bindValidText(handler: @escaping (Bool) -> Void) {
        textHandler = handler
    }

    func changeEditable(state: Bool) {
        isEditable = state
    }
    
    func fetchValues() -> (title: String, description: String, deadline: Date) {
        return (detailUseCase.fetchText(of: .title),
                detailUseCase.fetchText(of: .description),
                detailUseCase.fetchDeadline())
    }
}
