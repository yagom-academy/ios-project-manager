//
//  SheetViewModel.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/07.
//

import Foundation

final class SheetViewModel: ObservableObject {
    @Published var canEditable: Bool
    @Published var memo: Memo

    init(memo: Memo, canEditable: Bool) {
        self.memo = memo
        self.canEditable = canEditable
    }
}
