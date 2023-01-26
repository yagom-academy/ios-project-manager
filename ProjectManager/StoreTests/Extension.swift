//
//  Extension.swift
//  StoreTests
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
@testable import ProjectManager

extension Project {
  static let todoMockData: [Self] = [
    .init(title: "0", date: Date(), description: "0"),
    .init(title: "1", date: Date(), description: "1"),
    .init(title: "2", date: Date(), description: "2"),
    .init(title: "3", date: Date(), description: "3"),
    .init(title: "4", date: Date(), description: "4"),
    .init(title: "5", date: Date(), description: "5"),
  ]
}
