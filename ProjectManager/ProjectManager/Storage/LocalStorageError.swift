//
//  LocalStorageError.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/22.
//

enum LocalStorageError: Error {
    case creatError
    case updateError
    case deleteError
    
    var errorDescription: String {
        switch self {
        case .creatError:
            return "리스트 생성에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        case .updateError:
            return "리스트 수정에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        case .deleteError:
            return "리스트 삭제에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        }
    }
}
