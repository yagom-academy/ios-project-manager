//
//  DatabaseError.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/14.
//

import Foundation
import RxSwift

enum DatabaseError: LocalizedError {
    case createError
    case deleteError
    case updateError
    case changeError
    
    var errorDescription: String {
        switch self {
        case .createError:
            return "데이터 생성을 실패하였습니다."
        case .deleteError:
            return "데이터 삭제를 실패하였습니다."
        case .updateError:
            return "업데이트를 실패하였습니다."
        case .changeError:
            return "타입변환을 실패하였습니다."
        }
    }
}

protocol ErrorObservable {
    var error: Observable<DatabaseError> { get }
}
