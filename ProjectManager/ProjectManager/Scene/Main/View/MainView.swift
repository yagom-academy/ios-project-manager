//
//  MainView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    private(set) lazy var todoView = TaskSectionView(taskType: .todo)
    private(set) lazy var doingView = TaskSectionView(taskType: .doing)
    private(set) lazy var doneView = TaskSectionView(taskType: .done)

    private let baseStackView = UIStackView().then {
        $0.spacing = 15
        $0.distribution = .fillEqually
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray5
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(todoView)
        baseStackView.addArrangedSubview(doingView)
        baseStackView.addArrangedSubview(doneView)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
