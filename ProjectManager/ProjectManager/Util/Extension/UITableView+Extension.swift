//
//  UITableView+Extension.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/10.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UITableView {
  func modelLongPressed<T>(_ modelType: T.Type) -> ControlEvent<(UITableViewCell, T)> {
    let gesture = UILongPressGestureRecognizer(target: nil, action: nil)
    base.addGestureRecognizer(gesture)
    let source = gesture.rx.event
      .filter { $0.state == .began }
      .map { base.indexPathForRow(at: $0.location(in: base)) }
      .flatMap { [weak view = base as UITableView] indexPath -> Observable<(UITableViewCell, T)> in
        guard let view = view,
              let indexPath = indexPath,
              let cell = view.cellForRow(at: indexPath) else { return Observable.empty() }
        return Observable.zip(
          Observable.just(cell),
          Observable.just(try view.rx.model(at: indexPath))
        )
      }
    
    return ControlEvent(events: source)
  }
}
