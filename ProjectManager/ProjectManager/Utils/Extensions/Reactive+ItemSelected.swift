//
//  Reactive+ItemSelected.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/14.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    func listItemSelected<T>(_ itemType: T.Type) -> ControlEvent<(IndexPath, T)> {
        let event = Observable.zip(base.rx.itemSelected.asObservable(),
                                   base.rx.modelSelected(T.self).asObservable())
        return ControlEvent(events: event)
    }
}
