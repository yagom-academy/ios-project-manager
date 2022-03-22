//
//  ScheduleHistoryRepository.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation
import RxSwift

protocol ScheduleHistoryRepository {
    func fetch() -> Observable<[ScheduleAction]>
    func undo()
    func redo()
    func recode(action: ScheduleAction)
    func checkCanUndo() -> Observable<Bool>
    func checkCanRedo() -> Observable<Bool>
}
