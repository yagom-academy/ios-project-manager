//
//  TaskHeaderView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import SnapKit

final class TaskHeaderView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title1)
        $0.textColor = .black
    }
    
    private(set) lazy var taskCountLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.textAlignment = .center
    }
    
    private let headerStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 10
    }
    
    init(taskType: TaskType) {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        titleLabel.text = taskType.rawValue
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(headerStackView)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(taskCountLabel)
    }
    
    private func setupUILayout() {
        headerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        taskCountLabel.snp.makeConstraints {
            $0.height.equalTo(titleLabel.snp.height)
            $0.width.equalTo(taskCountLabel.snp.height)
        }
    }
}
