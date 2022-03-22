import Foundation
import UIKit

enum AlertFactory {
    static func createAlert(style: UIAlertController.Style = .actionSheet,
                            title: String? = nil,
                            message: String? = nil,
                            actions: UIAlertAction...) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { action in
            alert.addAction(action)
        }
        
        return alert
    }
}
