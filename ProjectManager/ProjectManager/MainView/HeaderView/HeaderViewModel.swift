//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import Combine

final class HeaderViewModel {
    let titleText: String
    let badgeText: String
    var badgeTextPublisher: PassthroughSubject<Int, Never>
    
    init(titleText: String, badgeText: String ,badgeTextPublisher: PassthroughSubject<Int, Never>) {
        self.titleText = titleText
        self.badgeText = badgeText
        self.badgeTextPublisher = badgeTextPublisher
    }
}
