//
//  Things.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import Foundation

struct Things {
    private var todoList: [Thing] = []
    private var doingList: [Thing] = []
    private var doneList: [Thing] = []
    static var shared: Things = Things()
    private init () {}
}
