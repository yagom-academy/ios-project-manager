//
//  TaskSwitchPopOverView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import RxSwift

final class TaskSwitchViewController: UIViewController {

// MARK: View
    
    private var doingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("DOING", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("DONE", for: .normal)
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

    var viewModel: TaskSwitchViewModel?
    let disposeBag = DisposeBag()

// MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
        addButtonActions()
        bindViewModel()
    }
}

// MARK: Action
extension TaskSwitchViewController {

    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }

        let doingButton = doingButton.rx.tap.asObservable()
        let doneButton = doneButton.rx.tap.asObservable()

        let input = TaskSwitchViewModel.Input(doingTrigger: doingButton,
                                              doneTrigger: doneButton)

        let output = viewModel.transform(input: input)

        output.doingSwitched
            .subscribe()
            .disposed(by: disposeBag)

        output.doneSwitched
            .subscribe()
            .disposed(by: disposeBag)
    }

    func sourceView(view: UIView) {
        self.popoverPresentationController?.sourceView = view
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

// MARK: Style
extension TaskSwitchViewController {

    func asPopover() {
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: 250, height: 100)
//        self.popoverPresentationController?.permittedArrowDirections = [.left]
    }

    private func layoutViews() {
        self.wholeStackView.addArrangedSubview(doingButton)
        self.wholeStackView.addArrangedSubview(doneButton)
        self.view.addSubview(wholeStackView)
        self.view.backgroundColor = .systemGray4
        self.view.directionalLayoutMargins = .init(top: 8, leading: 8,
                                                   bottom: 8, trailing: 8)

        NSLayoutConstraint.activate([
            self.wholeStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.wholeStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            self.wholeStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            self.wholeStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
