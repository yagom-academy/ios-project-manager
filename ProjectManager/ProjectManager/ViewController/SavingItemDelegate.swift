//
//  SavingItemDelegate.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/18.
//

import Foundation

protocol SavingItemDelegate: AnyObject {
    func doneButtonTappedForSaving(_ plan: Plan)
    func doneButtonTappedForResaving(_ plan: Plan)
}
