//
//  Task.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//
import Foundation

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let body: String
    let workState: WorkState
}
