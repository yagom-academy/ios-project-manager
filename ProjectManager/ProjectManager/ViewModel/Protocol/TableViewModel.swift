//
//  TableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import Foundation

protocol TableViewModel {
    var numOfList: Int { get }

    func itemInfo(at index: Int) -> Memo
    func removeCell(at index: Int)
    func insert(cell: Memo, at index: Int)
    func memoInfo(at index: Int) -> MemoTableViewCellModel?
}
