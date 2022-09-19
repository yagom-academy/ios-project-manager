//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

import Foundation

final class ListCellViewModel {
    func setupData(in cell: ListCell, with model: Todo) {
        cell.titleLabel.text = model.title
        cell.bodyLabel.text = model.body
        cell.dateLabel.text = model.date.timeIntervalSince1970.translateToDate()
        if model.date < Date() {
            cell.dateLabel.textColor = .red
        }
    }
}
