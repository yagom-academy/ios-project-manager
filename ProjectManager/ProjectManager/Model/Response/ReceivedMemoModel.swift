//
//  ReceivedMemoModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/09.
//

import Foundation

struct ReceivedMemoModel: Decodable {
    let items: [Memo]
    let metadata: Metadata
}
