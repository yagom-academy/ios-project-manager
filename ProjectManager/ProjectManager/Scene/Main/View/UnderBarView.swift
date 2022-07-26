//
//  UnderBarView.swift
//  ProjectManager
//
//  Created by Donnie, Grump on 2022/07/26.
//

import UIKit
import SnapKit

final class UnderBarView: UIView {
    
    private let baseStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
    }
    
    private let undoButton = UIButton().then {
        $0.setTitle("Undo", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .preferredFont(forTextStyle: .title2)
    }
    
    private let redoButton = UIButton().then {
        $0.setTitle("Redo", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .preferredFont(forTextStyle: .title2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(undoButton)
        baseStackView.addArrangedSubview(redoButton)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
