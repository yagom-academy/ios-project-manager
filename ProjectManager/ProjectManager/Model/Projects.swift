//
//  ProjectManager - Projects.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

final class Projects {
    static let shared = Projects()
    
    private init() { }
    
    var list: [Project] = [Project(title: "작업 할 일1", body: "할 일1을 표시하는 칸입니다.", status: .todo), Project(title: "작업 중인 일", body: "작업 중인 일을 표시하는 칸입니다.", status: .doing), Project(title: "작업 한 일", body: "작업 한 일을 표시하는 칸입니다.", status: .done), Project(title: "작업 할 일2", body: "할 일2을 표시하는 칸입니다.", status: .todo), Project(title: "작업 중인 일", body: "작업 중인 일을 표시하는 칸입니다.", status: .doing), Project(title: "작업 한 일", body: "작업 한 일을 표시하는 칸입니다.", status: .done), Project(title: "작업 할 일3", body: "할 일3을 표시하는 칸입니다.", status: .todo), Project(title: "작업 중인 일", body: "작업 중인 일을 표시하는 칸입니다.", status: .doing), Project(title: "작업 한 일", body: "작업 한 일을 표시하는 칸입니다.", status: .done), Project(title: "작업 할 일4", body: "할 일4을 표시하는 칸입니다.", status: .todo), Project(title: "작업 중인 일", body: "작업 중인 일을 표시하는 칸입니다.", status: .doing), Project(title: "작업 한 일", body: "작업 한 일을 표시하는 칸입니다.", status: .done), Project(title: "작업 할 일5", body: "할 일5을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일6", body: "할 일6을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일7", body: "할 일7을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일8", body: "할 일8을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일9", body: "할 일9을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일10", body: "할 일10을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일11", body: "할 일11을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일12", body: "할 일12을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일13", body: "할 일13을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일14", body: "할 일14을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일15", body: "할 일15을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일16", body: "할 일16을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일17", body: "할 일17을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일18", body: "할 일18을 표시하는 칸입니다.", status: .todo), Project(title: "작업 할 일19", body: "할 일19을 표시하는 칸입니다.", status: .todo)]
}
