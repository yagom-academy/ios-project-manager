//
//  PopOverView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/11.
//

import UIKit
import RxSwift
import RxCocoa

final class PopOverView: UIView {
    private let viewDisposeBag = DisposeBag()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(firstButton)
        buttonStackView.addArrangedSubview(secondButton)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setUpButtonTitle(first: ProjectStatus, second: ProjectStatus) {
        firstButton.setTitle(first.title, for: .normal)
        secondButton.setTitle(second.title, for: .normal)
    }
    
    func addButtonAction(_ cell: ProjectCell) {
        firstButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let status = ProjectStatus.convert(self?.firstButton.titleLabel?.text) else {
                    return
                }
            }
            .disposed(by: viewDisposeBag)
        
        secondButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let status = ProjectStatus.convert(self?.secondButton.titleLabel?.text) else {
                    return
                }
                cell.getData()?.updateStatus(status)
            }
            .disposed(by: viewDisposeBag)
    }
}
