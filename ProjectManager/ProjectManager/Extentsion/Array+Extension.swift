//
//  Array+Extension.swift
//  ProjectManager
//
//  Created by 김동용 on 2022/09/10.
//

// MARK: - Extentions

extension Array {
    func get(index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            print("index error!!")
            return nil
        }
    }
}
