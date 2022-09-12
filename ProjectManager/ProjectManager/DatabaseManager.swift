//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

protocol DatabaseManager {
    func createDatabase()
    func readDatabase()
    func updateDatabase()
    func deleteDatabase()
}
