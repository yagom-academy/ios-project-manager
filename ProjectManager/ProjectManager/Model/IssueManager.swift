//
//  IssueManager.swift
//  ProjectManager
//
//  Created by summercat 2023/01/16.
//

import Foundation

final class IssueManager {
    private(set) var issue: Issue
    
    init(issue: Issue) {
        self.issue = issue
    }
    
    // TODO: 나중에 Local/Remote DB에서 저장할 때 쓸 친구
    func createIssue(title: String?, body: String?, dueDate: Date? = Date()) {
        
    }
    
    // TODO: 나중에 Local/Remote DB에서 불러올 때 쓸 친구
    func fetchIssue() -> Issue? {
        return nil
    }
    
    // TODO: 나중에 Local/Remote DB에서 불러올 때 쓸 친구
    func updateIssue(title: String?, body: String?, dueDate: Date? = Date()) {
        
    }
    
    func deleteIssue() {
        
    }
}
