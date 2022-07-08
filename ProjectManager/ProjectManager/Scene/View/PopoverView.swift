//
//  PopoverView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import UIKit

final class PopoverView: UIView {
    private lazy var baseStackView = UIStackView(
        arrangedSubviews: [
            moveToToDoButton,
            moveToDoingButton,
            moveToDoneButton
        ]).then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
    
    private(set) lazy var moveToToDoButton = generatePopoverButton(
        title: "Move to TODO"
    )
    private(set) lazy var moveToDoingButton = generatePopoverButton(
        title: "Move to DOING"
    )
    private(set) lazy var moveToDoneButton = generatePopoverButton(
        title: "Move to DONE"
    )
    
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
