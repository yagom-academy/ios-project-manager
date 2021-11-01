//
//  Memo.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import Foundation

struct Memo {
    enum State {
        case todo
        case doing
        case done
    }
    
    var title: String
    var description: String
    var date: Date
    var state: State
}
