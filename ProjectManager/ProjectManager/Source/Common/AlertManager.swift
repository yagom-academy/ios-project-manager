//
//  AlertManager.swift
//  ProjectManager
//
//  Created by som on 2023/01/19.
//

import UIKit

final class AlertManager {
    func showDeleteAlert(handler: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: AlertMessage.deletePlan,
                                                         message: AlertMessage.deleteMessage,
                                                         preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소",
                                                        style: .cancel)
        let deleteAction: UIAlertAction = UIAlertAction(title: "삭제",
                                                        style: .destructive,
                                                        handler: handler)

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        return alert
    }

    func showErrorAlert(title: String) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title,
                                                         message: nil,
                                                         preferredStyle: .alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: "확인",
                                                         style: .default)
        alert.addAction(confirmAction)
        return alert
    }

    private enum AlertMessage {
        static let deletePlan = "할 일 삭제"
        static let deleteMessage = "정말로 삭제하시겠습니까?"
    }
}
