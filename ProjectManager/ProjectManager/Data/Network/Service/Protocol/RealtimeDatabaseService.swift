//
//  RealtimeDatabaseService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import Foundation

import RxSwift

protocol RealtimeDatabaseService {
  func fetch() -> Observable<[Card]>
  func write(cards: [Card]) -> Observable<Void>
}
