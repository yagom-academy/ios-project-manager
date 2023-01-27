//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/20.
//

import Foundation

final class HeaderViewModel {
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    private var title: String? {
        didSet {
            titleHandler?(title)
        }
    }
    
    private var cellCount: String? {
        didSet {
            cellCountHandler?(cellCount)
        }
    }
    
    var titleHandler: ((String?) -> Void)?
    var cellCountHandler: ((String?) -> Void)?
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func updateCellCount(to count: Int) {
        cellCount = numberFormatter.string(for: count)
    }
}
