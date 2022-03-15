//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/11.
//

import UIKit
import RxSwift
import RxCocoa

private enum Design {
    static let stackViewSpacing = 4.0
    static let buttonBackgroundColor = UIColor.white
    static let buttonTitleColor = UIColor.systemBlue
    static let buttonFont = UIFont.preferredFont(forTextStyle: .subheadline)
    static let viewBackgroundColor = UIColor.systemGray6
    static let stackViewLeadingAnchorConstant = 5.0
    static let stackViewTrailingAnchorConstant = -5.0
    static let stackViewTopAnchorConstant = 8.0
    static let stackViewBottomAnchorConstant = -8.0
}

class PopoverViewController: UIViewController {

    var viewModel: PopoverViewModel?
    private let bag = DisposeBag()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Design.stackViewSpacing
        return stackView
    }()

    let topButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Design.buttonBackgroundColor
        button.setTitleColor(Design.buttonTitleColor, for: .normal)
        button.titleLabel?.font = Design.buttonFont
        button.weakShadow()
        return button
    }()

    let bottomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Design.buttonBackgroundColor
        button.setTitleColor(Design.buttonTitleColor, for: .normal)
        button.titleLabel?.font = Design.buttonFont
        button.weakShadow()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        self.binding()
    }

}

private extension PopoverViewController {
    func configure() {
        self.view.backgroundColor = Design.viewBackgroundColor
        self.configureHierarchy()
        self.configureConstraint()
    }

    func configureHierarchy() {
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.topButton)
        self.stackView.addArrangedSubview(self.bottomButton)
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Design.stackViewLeadingAnchorConstant
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: Design.stackViewTrailingAnchorConstant
            ),
            self.stackView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: Design.stackViewTopAnchorConstant
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: Design.stackViewBottomAnchorConstant
            )
        ])
    }

    func binding() {
        let input = self.setInput()
        guard let output = self.viewModel?.transform(input: input, disposeBag: self.bag) else {
            return
        }

        self.bindingOutput(output: output)
    }

    func setInput() -> PopoverViewModel.Input {
        return PopoverViewModel.Input(
            topButtonDidTap: self.topButton.rx.tap.asObservable(),
            bottomButtonDidTap: self.bottomButton.rx.tap.asObservable(),
            viewDidDisappear: self.rx.methodInvoked(#selector(UIViewController.viewDidDisappear))
                .map { _ in }
        )
    }

    func bindingOutput(output: PopoverViewModel.Output) {
        output.topButtonTitleText
            .drive(self.topButton.rx.title())
            .disposed(by: self.bag)

        output.bottomButtonTitleText
            .drive(self.bottomButton.rx.title())
            .disposed(by: self.bag)
    }
}
