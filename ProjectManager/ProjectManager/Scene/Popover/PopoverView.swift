//
//  PopoverView.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 12/07/2022.
//

import UIKit

final class PopoverView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    private let moveToToDoButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.text = "Move to TODO"
        button.backgroundColor = .systemGray6
        button.tintColor = .systemBlue
        return button
    }()
    
    private let moveToDoingButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.text = "Move to DOING"
        button.backgroundColor = .systemGray6
        button.tintColor = .systemBlue
        return button
    }()
    
    private let moveToDoneButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.text = "Move to Done"
        button.backgroundColor = .systemGray6
        button.tintColor = .systemBlue
        return button
    }()
}
