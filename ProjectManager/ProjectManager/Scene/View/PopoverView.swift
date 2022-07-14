//
//  PopoverView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import UIKit

final class PopoverView: UIView {
    
    fileprivate enum Constants {
        static let moveToToDoTitle: String = "Move to TODO"
        static let moveToDoingTitle: String = "Move to DOING"
        static let moveToDoneTitle: String = "Move to DONE"
    }
    
    private let baseStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private(set) lazy var moveToToDoButton = generatePopoverButton(title: Constants.moveToToDoTitle)
    private(set) lazy var moveToDoingButton = generatePopoverButton(title: Constants.moveToDoingTitle)
    private(set) lazy var moveToDoneButton = generatePopoverButton(title: Constants.moveToDoneTitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(moveToToDoButton)
        baseStackView.addArrangedSubview(moveToDoingButton)
        baseStackView.addArrangedSubview(moveToDoneButton)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func generatePopoverButton(title: String) -> UIButton {
        return UIButton().then {
            $0.titleLabel?.font = .preferredFont(forTextStyle: .title3)
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.backgroundColor = .white
        }
    }
}
