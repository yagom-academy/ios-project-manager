//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import Combine

final class HeaderViewModel {
    @Published var titleText: String
    @Published var badgeText: String
    
    init(titleText: String, badgeCount: Int) {
        self.titleText = titleText
        self.badgeText = String(badgeCount)
    }
}
