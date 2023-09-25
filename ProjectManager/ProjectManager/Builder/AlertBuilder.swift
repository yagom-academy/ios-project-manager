//
//  AlertBuilder.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import UIKit

final class AlertBuilder {
    let alertController: UIAlertController
    private var controllerTitle: String = ""
    private var controllerMessage: String = ""
    private var alertActions: [UIAlertAction] = []
    
    init(viewController: UIViewController, prefferedStyle: UIAlertController.Style) {
        self.alertController = UIAlertController(title: nil, message: nil, preferredStyle: prefferedStyle)
    }
    
    func setControllerTitle(title: String) {
        self.controllerTitle = title
    }
    
    func setControllerMessage(message: String) {
        self.controllerMessage = message
    }
    
    func addAction(_ actionType: AlertActionType, action: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: actionType.title, style: actionType.style, handler: action)
        alertActions.append(action)
    }
    
    func makeAlertController() -> UIAlertController {
        alertController.title = controllerTitle
        alertController.message = controllerMessage
        alertActions.forEach { alertController.addAction($0) }
        
        return alertController
    }
}

extension AlertBuilder {
    enum AlertActionType {
        case confirm
        case cancel
        case delete
        case other(title: String, style: UIAlertAction.Style)
        
        var title: String {
            switch self {
            case .confirm:
                return "확인"
            case .cancel:
                return "취소"
            case .delete:
                return "삭제"
            case .other(let title, _):
                return title
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .cancel:
                return .cancel
            case .delete:
                return .destructive
            case .other(_, let style):
                return style
            default:
                return .default
            }
        }
    }
}

