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
        setUp()
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Move to TODO", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private let moveToDoingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Move to DOING", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private let moveToDoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Move to Done", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    // MARK: setUp
    
    private func setUp() {
        backgroundColor = .systemGray6
        setUpSubView()
        setConstraint()
    }
    
    private func setUpSubView() {
        baseStackView.addSubViews(moveToDoingButton, moveToToDoButton, moveToDoneButton)
        addSubview(baseStackView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            baseStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            baseStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            baseStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            baseStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            moveToToDoButton.leadingAnchor.constraint(equalTo: baseStackView.leadingAnchor),
            moveToToDoButton.trailingAnchor.constraint(equalTo: baseStackView.trailingAnchor),
            
            moveToDoingButton.leadingAnchor.constraint(equalTo: baseStackView.leadingAnchor),
            moveToDoingButton.trailingAnchor.constraint(equalTo: baseStackView.trailingAnchor),
            
            moveToDoneButton.leadingAnchor.constraint(equalTo: baseStackView.leadingAnchor),
            moveToDoneButton.trailingAnchor.constraint(equalTo: baseStackView.trailingAnchor)
        ])
    }
}
