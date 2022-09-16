//
//  SendDelegate .swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/16.
//

protocol SendDelegate: AnyObject {
    func sendData<T>(
        _ data: T
    )
}
