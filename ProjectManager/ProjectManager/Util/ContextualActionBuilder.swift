//
//  ContextualActionBuilder.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 13/07/2022.
//

import UIKit

struct ContextualAction {
    let title: String?
    let backgroundColor: UIColor?
    let image: UIImage?
    let style: UIContextualAction.Style
    let completionHandler: (() -> Void)?
}

final class ContextualActionBuilder {
    private var actions = [ContextualAction]()
    
    func addAction(
        title: String? = nil,
        backgroundColor: UIColor? = nil,
        image: UIImage? = nil,
        style: UIContextualAction.Style,
        action: (() -> Void)?
    ) -> Self {
        actions.append(
            ContextualAction(
                title: title,
                backgroundColor: backgroundColor,
                image: image,
                style: style,
                completionHandler: action
            )
        )
        
        return self
    }
    
    func build() -> UISwipeActionsConfiguration {
        let actions = actions.map { action -> UIContextualAction in
            let contextualAction = UIContextualAction(style: action.style, title: action.title) { _, _, completion in
                action.completionHandler?()
                completion(true)
            }
            
            contextualAction.image = action.image
            contextualAction.backgroundColor = action.backgroundColor
            
            return contextualAction
        }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}
