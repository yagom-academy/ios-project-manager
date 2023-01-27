//
//  SwitchTaskViewController.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import RxSwift

fileprivate enum Common {
    static let doingTitle = "DOING"
    static let doneTitle = "DONE"
}

final class SwitchTaskViewController: UIViewController {

// MARK: View
    
    private var doingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(Common.doingTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(Common.doneTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private var wholeStackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()

    // MARK: Initialization
    
    var viewModel: SwitchTaskViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
        configureAsPopover()
        addButtonActions()
        bindViewModel()
    }
}

// MARK: Function

extension SwitchTaskViewController {

    private func configureAsPopover() {
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 250, height: 100)
        popoverPresentationController?.permittedArrowDirections = [.left, .right]
    }
    
    func sourceView(view: UIView) {
        popoverPresentationController?.sourceView = view
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

    @objc
    private func tapDoingButton() {
        self.dismiss(animated: true)
    }

    @objc
    private func tapDoneButton() {
        self.dismiss(animated: true)
    }
}

// MARK: Layout

extension SwitchTaskViewController {

    private func layoutViews() {
        wholeStackView.addArrangedSubview(doingButton)
        wholeStackView.addArrangedSubview(doneButton)
        view.addSubview(wholeStackView)
        view.backgroundColor = .systemGray4
        view.directionalLayoutMargins = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            wholeStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            wholeStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
