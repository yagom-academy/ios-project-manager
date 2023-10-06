//
//  AlertBuilder.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import UIKit

struct AlertBuilder {
    let configuration: AlertConfiguration
    
    init(prefferedStyle: UIAlertController.Style) {
        self.configuration = AlertConfiguration(prefferedStyle: prefferedStyle)
    }
    
    @discardableResult
    func setTitle(_ title: String) -> Self {
        configuration.title = title
        return self
    }
    
    @discardableResult
    func setMessage(_ message: String) -> Self {
        configuration.message = message
        return self
    }
    
    @discardableResult
    func addAction(_ actionType: AlertActionType, action: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: actionType.title, style: actionType.style, handler: action)
        configuration.actions.append(action)
        return self
    }
    
    func build() -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: configuration.prefferedStyle)
        alertController.title = configuration.title
        alertController.message = configuration.message
        configuration.actions.forEach { alertController.addAction($0) }
        return alertController
    }
}

extension AlertBuilder {
    final class AlertConfiguration {
        let prefferedStyle: UIAlertController.Style
        var title: String = ""
        var message: String = ""
        var actions: [UIAlertAction] = []
        
        init(prefferedStyle: UIAlertController.Style) {
            self.prefferedStyle = prefferedStyle
        }
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

