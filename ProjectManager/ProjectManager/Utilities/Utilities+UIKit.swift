//
//  Utilities+UIKit.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
