//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Toy on 1/24/24.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - Property
    private let titleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        return label
    }()
    
    private let circleView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    // text 는 테스트용으로 설정하였습니다.
    // 다음 스텝에서 수정하겠습니다.
    private let numberOfCircleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "2"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
        self.addBorder(at: .bottom, color: .systemGray4, thickness: 0.5)
    }
    
    // MARK: - Helper
    init(frame: CGRect, schedule: Schedule) {
        self.titleLabel.text = schedule.discription
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupnumberOfCircleLabel()
        setupStackView()
    }
    
    private func setupConstraints() {
        setupCircleViewConstraint()
        setupnumberOfCircleLabelConstraint()
        setupStackViewConstraint()
    }
    
    private func setupnumberOfCircleLabel() {
        circleView.addSubview(numberOfCircleLabel)
    }
    
    private func setupCircleViewConstraint() {
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 25),
            circleView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupnumberOfCircleLabelConstraint() {
        NSLayoutConstraint.activate([
            numberOfCircleLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            numberOfCircleLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(circleView)
        self.addSubview(stackView)
    }
    
    private func setupStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
    
}
