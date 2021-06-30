//
//  ViewController.swift
//  AlanPractice2
//
//  Created by YB on 2021/06/30.
//

import UIKit

class ViewController: UIViewController {

    let stackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.alignment = .fill
        myStackView.axis = .vertical

        return myStackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // 배경색
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        let userName = UILabel.init()
        let userAddress = UILabel.init()

        userName.frame = CGRect(x: 10.0, y: 40.0, width: 100.0, height: 21.0)
        userAddress.frame = CGRect(x: 30.0, y: 60.0, width: 150.0, height: 52.0)
        
        userName.text = "Alan"
        userAddress.text = "제주시"
        
        userName.backgroundColor = .blue
        userAddress.backgroundColor = .darkGray
        
        stackView.addArrangedSubview(userName)
        stackView.addArrangedSubview(userAddress)
        
        let userProfile = UIImageView.init()


        
    }

}

