//
//  SwitchTaskViewController.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

fileprivate enum Titles {
    static let doing = "DOING"
    static let done = "DONE"
}

final class SwitchTaskViewController: UIViewController {
    
    var viewModel: SwitchTaskViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: View(s)
    
    private let doingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(Titles.doing, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(Titles.done, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    private let wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        return stack
    }()
    
    // MARK: Override(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        combineViews()
        configureViewConstraints()
        configureAsPopover()
        addButtonActions()
        bindViewModel()
    }
    
    // MARK: Function(s)
    
    func sourceView(view: UIView) {
        popoverPresentationController?.sourceView = view
    }
    
    // MARK: Private Function(s)
    
    private func configureAsPopover() {
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 250, height: 100)
        popoverPresentationController?.permittedArrowDirections = [.left, .right]
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        let doingButton = doingButton.rx.tap.asObservable()
        let doneButton = doneButton.rx.tap.asObservable()
        
        let input = SwitchTaskViewModel.Input(doingTrigger: doingButton,
                                              doneTrigger: doneButton)
        let output = viewModel.transform(input: input)
        
        output.doingSwitched
            .subscribe()
            .disposed(by: disposeBag)
        
        output.doneSwitched
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func addButtonActions() {
        doingButton.addTarget(self, action: #selector(tapDoingButton), for: .touchDown)
        doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchDown)
    }
    
    private func combineViews() {
        wholeStackView.addArrangedSubview(doingButton)
        wholeStackView.addArrangedSubview(doneButton)
        view.addSubview(wholeStackView)
        view.backgroundColor = .systemGray4
        view.directionalLayoutMargins = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
    }
    
    private func configureViewConstraints() {
        
        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            wholeStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            wholeStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func tapDoingButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func tapDoneButton() {
        dismiss(animated: true)
    }
}
