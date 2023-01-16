//
//  IssueManager.swift
//  ProjectManager
//
//  Created by summercat 2023/01/16.
//

import Foundation

final class IssueManager {
    private var issue: Issue?
    
    init(issue: Issue? = nil) {
        self.issue = issue
    }
    
    func createIssue(title: String?, body: String?, dueDate: Date? = Date()) {
        
    }
    
    func fetchIssue() -> Issue? {
        return nil
    }
    
    func updateIssue(title: String?, body: String?, dueDate: Date? = Date()) {
        
    }
    
    func deleteIssue() {
        
    }
}
