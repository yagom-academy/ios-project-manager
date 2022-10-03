//
//  JSONError.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/29.
//

import Foundation

enum JSONError: LocalizedError {
    case defaultError
    case emptyError

    var errorDescription: String? {
        switch self {
        case .defaultError:
            return NSLocalizedString(
                "Error Occurs When getData() method called",
                comment: "Default Error"
            )
        case .emptyError:
            return NSLocalizedString(
                "Failed To Decode Data Because Of Emptiness",
                comment: "Empty Data Error"
            )
        }
    }
}
