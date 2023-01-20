//
//  NameSpace.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/19.
//

import Foundation

enum HeaderViewValue {
    static let identifier = "ListHeaderView"
}

enum ListTableViewValue {
    static let identifier = "ListTableViewCell"
}

enum PlaceHolder {
    static let itemViewTitle = " Title"
    static let itemViewBody = """
                      할일의 내용을 입력해주세요.
                      입력 가능한 글자수는 1000자로 제한됩니다.
                      """
    static let tableViewTitle = "title"
    static let tableViewBody = "body"
    static let tableViewDate = "0000. 0. 0"
}

enum DatePickerValue {
    static let locale = "ko-kr"
    static let timezone = "KST"
    static let dateFormat = "yyyy. M. d."
}

enum ListViewTitle {
    static let navigationBar = "Project Manager"
    
    enum Header {
        static let todo = "TODO"
        static let doing = "DOING"
        static let done = "DONE"
    }
}

enum SwipeActionTitle {
    static let delete = "Delete"
    static let deleteImage = "xmark.bin"
}

enum TodoViewTitle {
    static let navigationBar = "TODO"
    static let cancel = "Cancel"
    static let done = "Done"
    static let edit = "Edit"
}

enum TodoItemValue {
    static let bodyLimit = 1000
}

enum AlertMenu {
    static let toTodo = "Move To TODO"
    static let toDoing = "Move To DOING"
    static let toDone = "Move To DONE"
}

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
