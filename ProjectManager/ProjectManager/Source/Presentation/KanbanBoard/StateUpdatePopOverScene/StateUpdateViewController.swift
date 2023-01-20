//
//  StateUpdateViewController.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import UIKit

import RxSwift
import RxCocoa

final class StateUpdateViewController: UIViewController {
    private enum Constant {
        static let contentSize = CGSize(width: 200, height: 100)
        static let spacing = CGFloat(8)
    }
    private let moveToTodoButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Move To Todo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    private let moveToDoingButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Move To Doing", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    private let moveToDoneButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Move To Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = Constant.spacing
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    private let viewModel: StateUpdateViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: StateUpdateViewModel, style state: Task.State) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setStyle(of: state)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
}

private extension StateUpdateViewController {
    func setUI() {
        view.backgroundColor = .systemBackground
        preferredContentSize = Constant.contentSize
        
        [moveToTodoButton, moveToDoingButton, moveToDoneButton].forEach(stackView.addArrangedSubview)
        view.addSubview(stackView)
        
        let safeArea = view.safeAreaLayoutGuide
        let spacing = Constant.spacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: spacing),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: -spacing),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: -spacing)
        ])
    }
    
    func bind() {
        let input = StateUpdateViewModel.Input(
            moveToTodoButtonTapEvent: moveToTodoButton.rx.tap.asObservable(),
            moveToDoingButtonTapEvent: moveToDoingButton.rx.tap.asObservable(),
            moveToDoneButtonTapEvent: moveToDoneButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        output.isSuccess
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setStyle(of state: Task.State) {
        switch state {
        case .toDo:
            moveToTodoButton.isHidden = true
        case .doing:
            moveToDoingButton.isHidden = true
        case .done:
            moveToDoneButton.isHidden = true
        }
    }
}
