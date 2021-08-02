//
//  TaskRepositoryDelegate.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/30.
//

protocol TaskRepositoryDelegate: AnyObject {

    func networkDidConnect()
    func networkDidDisconnect()
}
