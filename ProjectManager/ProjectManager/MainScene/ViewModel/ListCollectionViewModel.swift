//
//  ListCollectionViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class ListCollectionViewModel {
    let category: String

    init(category: String) {
        self.category = category
    }

    func bindList(_ completion: @escaping ([Todo]) -> Void) {
        TodoDataManager.shared.didChangedData.append { [weak self] in
            guard let self = self else { return }
            let changedList = self.fetchList()
            completion(changedList)
        }
    }
    
    func fetchList() -> [Todo] {
        return TodoDataManager.shared.read(category: self.category)
    }
    
    func delete(todo: Todo) {
        TodoDataManager.shared.delete(todo)
    }
}
