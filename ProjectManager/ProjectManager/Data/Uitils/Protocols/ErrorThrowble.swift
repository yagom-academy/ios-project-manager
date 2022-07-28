//
//  ErrorThrowble.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/28.
//

import Foundation
import RxRelay

protocol ErrorThrowble {
    var errorObserver: PublishRelay<TodoError> { get }
}
