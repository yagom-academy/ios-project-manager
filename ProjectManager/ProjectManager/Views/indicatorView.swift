//
//  indicatorView.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/31.
//

import Foundation
import UIKit

class IndicatorView {
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    private func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.containerView.frame = window.frame
        self.containerView.center = window.center
        self.containerView.backgroundColor = .clear
        self.containerView.addSubview(self.activityIndicator)
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    func showIndicator() {
        show()
        self.containerView.backgroundColor = UIColor(white: 0x000000, alpha: 1)
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .large
        self.activityIndicator.color = UIColor.gray
        self.activityIndicator.center = self.containerView.center
        self.activityIndicator.startAnimating()
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
}
