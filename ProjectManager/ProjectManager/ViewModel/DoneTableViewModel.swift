//
//  DoneTableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import Foundation

final class DoneTableViewModel: TableViewModel {
    private let dateFormatter = DateFormatter()
    internal var memoList: Observable<[MemoTableViewCellModel]> = Observable([])
    
    var numOfList: Int {
        return memoList.value?.count ?? 0
    }
    
    func fetchData() {
        memoList.value = doneDummy.compactMap({
            MemoTableViewCellModel(
                title: $0.title,
                content: $0.content,
                date: dateFormatter.numberToString(number: $0.date),
                isDateColorRed: checkDateColor(date: dateFormatter.numberToString(number: $0.date))
            )
        })
    }
    
    private func checkDateColor(date stringOfDate: String) -> Bool {
        let stringOfCurrentDate = dateFormatter.dateToString(date: Date())
        return stringOfDate < stringOfCurrentDate ? true : false
    }
    
    // TODO: - memoInfo, itemInfo 이름 변경
    func memoInfo(at index: Int) -> MemoTableViewCellModel? {
        return memoList.value?[index]
    }
    
    func itemInfo(at index: Int) -> Memo {
        let item = memoInfo(at: index)!
        return Memo(
            title: item.title,
            content: item.content,
            date: dateFormatter.stringToNumber(string: item.date)
        )
    }
    
    func removeCell(at index: Int) {
        memoList.value?.remove(at: index)
        
        // TODO: - server API "remove"
        doneDummy.remove(at: index)
    }
    
    func insert(
        cell: Memo,
        at index: Int
    ) {
        let memoTableViewCellModel = MemoTableViewCellModel(
            title: cell.title,
            content: cell.content,
            date: dateFormatter.numberToString(number: cell.date),
            isDateColorRed: checkDateColor(date: dateFormatter.numberToString(number: cell.date))
        )
        memoList.value?.insert(
            memoTableViewCellModel,
            at: index
        )
        
        // TODO: - server API "insert"
        doneDummy.insert(
            cell,
            at: index
        )
    }
}
