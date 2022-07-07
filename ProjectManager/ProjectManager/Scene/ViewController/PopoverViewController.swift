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
    
    private(set) lazy var moveToToDoButton = UIButton().then {
        $0.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        $0.setTitle("Move to TODO", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .white
    }
    
    private(set) lazy var moveToDoingButton = UIButton().then {
        $0.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        $0.setTitle("Move to DOING", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .white
    }
    
    private(set) lazy var moveToDoneButton = UIButton().then {
        $0.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        $0.setTitle("Move to DONE", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .white
    }
    
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
