//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 박세웅 on 2022/07/08.
//

import UIKit

final class PopoverView: UIView {
    private lazy var baseStackView = UIStackView(arrangedSubviews: [
        moveToToDoButton,
        moveToDoingButton,
        moveToDoneButton
    ]).then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private(set) lazy var moveToToDoButton = generatePopoverButton(title: "Move to TODO")
    private(set) lazy var moveToDoingButton = generatePopoverButton(title: "Move to DOING")
    private(set) lazy var moveToDoneButton = generatePopoverButton(title: "Move to DONE")
    
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
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        return button
    }
}

final class PopoverViewController: UIViewController {
    let popoverView = PopoverView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        view = popoverView
    }
    
    func setPopoverAction(_ task: TaskType) {
        switch task {
        case .todo:
            popoverView.moveToToDoButton.isHidden = true
        case .doing:
            popoverView.moveToDoingButton.isHidden = true
        case .done:
            popoverView.moveToDoneButton.isHidden = true
        }
    }
}
