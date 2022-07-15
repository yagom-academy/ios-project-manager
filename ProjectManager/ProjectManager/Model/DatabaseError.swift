//
//  DatabaseError.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/14.
//

import Foundation
import RxRelay

enum DatabaseError: LocalizedError {
    case createError
    case deleteError
    case updateError
    case changeError
    
    var errorDescription: String {
        switch self {
        case .createError:
            return "프로젝트 생성을 실패하였습니다."
        case .deleteError:
            return "프로젝트 삭제를 실패하였습니다."
        case .updateError:
            return "업데이트를 실패하였습니다."
        case .changeError:
            return "프로젝트 이동을 실패하였습니다."
        }
    }
}

protocol ErrorObservable {
    var error: PublishRelay<DatabaseError> { get }
}
