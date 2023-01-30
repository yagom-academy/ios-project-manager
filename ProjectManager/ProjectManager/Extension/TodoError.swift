//
//  TodoError.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/25.
//

enum TodoError {
    case loadError
    
    var title: String {
        switch self {
        case .loadError:
            return "데이터 로드 오류"
        }
    }
    
    var message: String {
        switch self {
        case .loadError:
            return "해당 항목의 데이터를 가져올 수 없습니다."
        }
    }
}
