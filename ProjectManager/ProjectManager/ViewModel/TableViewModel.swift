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
        NetworkManager().responseData(
            type: tableViewType,
            page: 1) { receivedMemoModel in
            self.memoList.value = receivedMemoModel.items.compactMap({
                MemoTableViewCellModel(
                    title: $0.title,
                    content: $0.content,
                    dueDate: self.dateFormatter.changeStringDateFormat(date: $0.dueDate),
                    isDateColorRed: self.checkDateColor(
                        date: $0.dueDate
                    )
                )
            })
        }
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
            id: "test",
            title: item.title,
            content: item.content,
            dueDate: item.dueDate, //dateFormatter.stringToDate(string: item.dueDate),
            memoType: "todo"
        )
    }
    
    func removeCell(at index: Int) {
        // TODO: - server API "remove"
        Dummy.shared.remove(
            tableViewType: tableViewType,
            at: index
        )
        
        fetchData()
    }
    
    func insert(
        cell: Memo,
        at index: Int
    ) {
        // TODO: - server API "insert"
        Dummy.shared.insert(
            tableViewType: tableViewType,
            cell: cell,
            at: index
        )
        
        fetchData()
    }
}
