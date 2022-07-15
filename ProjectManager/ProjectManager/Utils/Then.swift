//
//  Then.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import Foundation

protocol Then {}

extension Then where Self: AnyObject {
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}
