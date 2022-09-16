//
//  ChangeWorkStateViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/16.
//

import UIKit
import RxSwift

class ChangeWorkStateViewController: UIViewController {
    // MARK: - UI
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let moveButton: (String) -> UIButton = { title in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .systemBackground
        return button
    }
    
    private lazy var moveTodoButton = moveButton("Move To TODO")
    private lazy var moveDoingButton = moveButton("Move To DOING")
    private lazy var moveDoneButton = moveButton("Move To DONE")
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    // MARK: - Methods
    func setupView(for work: Work, _ viewModel: WorkViewModel) {
        switch work.state {
        case .todo:
            verticalStackView.addArrangedSubview(moveDoingButton)
            verticalStackView.addArrangedSubview(moveDoneButton)
        case .doing:
            verticalStackView.addArrangedSubview(moveTodoButton)
            verticalStackView.addArrangedSubview(moveDoneButton)
        case .done:
            verticalStackView.addArrangedSubview(moveTodoButton)
            verticalStackView.addArrangedSubview(moveDoingButton)
        }
        
        bindButtonTap(work: work, viewModel: viewModel)
    }
    
    private func setupConstraints() {
        self.view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            verticalStackView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            verticalStackView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func bindButtonTap(work: Work, viewModel: WorkViewModel) {
        moveTodoButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                viewModel.chnageWorkState(work, to: .todo)
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        moveDoingButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                viewModel.chnageWorkState(work, to: .doing)
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        moveDoneButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                viewModel.chnageWorkState(work, to: .done)
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}
