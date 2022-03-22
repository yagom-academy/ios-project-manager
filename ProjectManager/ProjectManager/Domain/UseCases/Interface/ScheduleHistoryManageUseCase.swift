//
//  ScheduleItemUseCase.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/16.
//

import Foundation
import RxSwift

protocol ScheduleHistoryManageUseCase {
    func fetch() -> Observable<[ScheduleAction]>
    func checkCanUndo() -> Observable<Bool>
    func checkCanRedo() -> Observable<Bool>
    func undo()
    func redo()
}
