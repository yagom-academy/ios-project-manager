//
//  ToastShowable.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/06.
//

import UIKit

protocol ToastShowable where Self: UIViewController {
    func showToast(message: String)
}

extension ToastShowable {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75,
                                               y: view.frame.size.height-100,
                                               width: 150,
                                               height: 35))
        
        toastLabel.backgroundColor = .black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 15)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}
