//
//  Coordinator.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/21.
//
import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var coordinatorController: UINavigationController { get set }
    func moveStart()
}
