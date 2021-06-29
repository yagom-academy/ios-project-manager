//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SwiftUI
import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let testLabel = UILabel()
        testLabel.text = "프로젝트 관리앱 코드로 빈화면 만들기"
        
        view.addSubview(testLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        testLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true

    }


}

