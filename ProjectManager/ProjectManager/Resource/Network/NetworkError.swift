//
//  NetworkError.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/29.
//

import Foundation

enum NetworkError: LocalizedError {
    case failedToConnect

    var errorDescription: String? {
        switch self {
        case .failedToConnect:
            return NSLocalizedString(
                "Failed To Connect To Networking Service",
                comment: "Network Connection Error"
            )
        }
    }
}
