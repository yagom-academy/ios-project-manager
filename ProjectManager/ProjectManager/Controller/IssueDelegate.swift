//
//  IssueDelegate.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/17.
//

protocol IssueDelegate {
    func shouldAdd(issue: Issue)
    func shouldUpdate(issue: Issue)
}
