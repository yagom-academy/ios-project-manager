//
//  Memo.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

struct Memo {
    var title: String
    var body: String
    var date: Date
    var state: State

    enum State: String, CaseIterable {
        case todo
        case done
        case doing
    }
}
