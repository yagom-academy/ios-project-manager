//
//  CustomHeader.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class CustomHeader: UIView {

    lazy var titleLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title1)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        //$0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    lazy var workCountLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.backgroundColor = .black
        $0.text = "0"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        
    }
    
    lazy var baseStackView = UIStackView(arrangedSubviews: [titleLabel, workCountLabel]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(workType: WorkType) {
        super.init(frame: .zero)
        backgroundColor = .systemGray5
        titleLabel.text = workType.value
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
            $0.edges.equalToSuperview()
        }
        
        NSLayoutConstraint.activate([
            baseStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),

        ])
        
        NSLayoutConstraint.activate([
            workCountLabel.widthAnchor.constraint(equalToConstant: 25),
            
            workCountLabel.widthAnchor.constraint(equalTo: workCountLabel.heightAnchor)
        ])
    }
}
