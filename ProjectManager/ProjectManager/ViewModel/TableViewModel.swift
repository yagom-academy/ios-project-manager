//
//  TableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import Foundation

final class TableViewModel {
    private let dateFormatter = DateFormatter()
    let tableViewType: TableViewType
    var memoList: Observable<[MemoTableViewCellModel]> = Observable([])
    var numOfList: Int {
        return memoList.value?.count ?? 0
    }
    
    init(tableViewType: TableViewType) {
        self.tableViewType = tableViewType
    }
    
    func fetchData() {
        memoList.value = Dummy.shared.dummy(as: tableViewType).compactMap({
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
    
    // TODO: - 이름 변경
    // memoInfo, itemInfo, cellInfo
    // step2에서 cellInfo를 변경하면서 다 변경해주자
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
        Dummy.shared.remove(
            tableViewType: tableViewType,
            at: index
        )
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
        Dummy.shared.insert(
            tableViewType: tableViewType,
            cell: cell,
            at: index
        )
    }
}
