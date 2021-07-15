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
    // TODO: - MemoTableViewCellModel에 id값을 넣는것에 대해 고민하자..
    var memoList: Observable<[MemoTableViewCellModel]> = Observable([])
    var numOfList: Int {
        return memoList.value?.count ?? 0
    }
    
    init(tableViewType: TableViewType) {
        self.tableViewType = tableViewType
    }
    
    func fetchData() {
        NetworkManager().getData(
            type: tableViewType,
            page: 1
        ) { receivedMemoModel in
            self.memoList.value = receivedMemoModel.items.compactMap({
                MemoTableViewCellModel(
                    id: $0.id,
                    title: $0.title,
                    content: $0.content,
                    dueDate: self.dateFormatter.changeStringDateFormat(
                        date: $0.dueDate,
                        beforeDateFormat: .ymd_hms,
                        afterDateFormat: .ymd
                    ),
                    isDateColorRed: self.checkDateColor(
                        date: $0.dueDate
                    )
                )
            })
        }
    }
    
    private func checkDateColor(date stringOfDate: String) -> Bool {
        let date = dateFormatter.changeStringDateFormat(
            date: stringOfDate,
            beforeDateFormat: .ymd_hms,
            afterDateFormat: .ymd
        )
        let currentDate = dateFormatter.dateToString(
            date: Date(),
            dateFormat: .ymd
        )
        
        return date < currentDate ? true : false
    }
    
    // TODO: - 네이밍 좀 더 가독성있게 변경하기
    // memoInfo, itemInfo, cellInfo
    func memoInfo(at index: Int) -> MemoTableViewCellModel? {
        return memoList.value?[index]
    }
    
    func itemInfo(
        at index: Int,
        id: String = ""
    ) -> Memo {
        let item = memoInfo(at: index)!
        let dueDate = dateFormatter.changeStringDateFormat(
            date: item.dueDate,
            beforeDateFormat: .ymd_hms,
            afterDateFormat: .ymd
        )
        return Memo(
            id: item.id,
            title: item.title,
            content: item.content,
            dueDate: dueDate,
            memoType: tableViewType.rawValue
        )
    }
    
    func removeCell(id: String) {
        NetworkManager().deleteData(id: id) {
            self.fetchData()
        }
    }
    
    func insert(
        cell: Memo,
        destinationTableViewType: TableViewType
    ) {
        let dueDate = DateFormatter().changeStringDateFormat(
            date: cell.dueDate,
            beforeDateFormat: .ymd,
            afterDateFormat: .ymd_hms
        )
        let data = Memo(
            id: cell.id,
            title: cell.title,
            content: cell.content,
            dueDate: dueDate,
            memoType: destinationTableViewType.rawValue
        )
        NetworkManager().postData(data: data) {
            self.fetchData()
        }
    }
}
