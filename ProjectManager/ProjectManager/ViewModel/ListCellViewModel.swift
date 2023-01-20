//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/17.
//

import UIKit

final class ListCellViewModel {
    var work: Work {
        didSet {
            cellHandler?(work)
            colorHandler?(checkEndDateColor(date: work.endDate))
        }
    }

    private var cellHandler: ((Work) -> Void)?
    private var colorHandler: ((UIColor) -> Void)?
    
    init(work: Work) {
        self.work = work
    }
    
    func load() {
        cellHandler?(work)
        colorHandler?(checkEndDateColor(date: work.endDate))
    }
    
    func bindTextValue(handler: @escaping (Work) -> Void) {
        cellHandler = handler
    }
    
    func bindTextColor(handler: @escaping (UIColor) -> Void) {
        colorHandler = handler
    }
    
    func checkEndDateColor(date: Date) -> UIColor {
        if date < Date() {
            return .red
        } else {
            return .black
        }
    }
    
    func pressEndedIsValid(state: UIGestureRecognizer.State, delegate: CellDelegate?, sourceView: UIView) {
        if state == .ended {
            delegate?.showPopover(soruceView: sourceView, work: work)
        }
    }
}
