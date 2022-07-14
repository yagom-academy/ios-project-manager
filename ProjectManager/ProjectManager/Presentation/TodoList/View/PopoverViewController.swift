//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/13.
//

import UIKit
import SnapKit

class PopoverViewController: UIViewController {
    let firstButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private lazy var buttomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton, secondButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .systemGray5
        view.addSubview(buttomStackView)
        buttomStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
