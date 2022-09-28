//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class HeaderViewModel {
    let category: String

    init(category: String) {
        self.category = category
    }
    
    func bindListCount(_ completion: @escaping (Int) -> Void) {
        TodoDataManager.shared.didChangedData.append { [weak self] in
            guard let self = self else { return }
            let count = self.fetchCount()
            completion(count)
        }
    }
    
    func fetchCount() -> Int {
        TodoDataManager.shared.read(category: category).count
    }
}
