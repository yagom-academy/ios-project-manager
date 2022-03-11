//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/11.
//

import UIKit
import RxSwift
import RxCocoa

class PopoverViewController: UIViewController {

    var viewModel: PopoverViewModel?
    private let bag = DisposeBag()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()

    let topButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
        return button
    }()

    let bottomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
        return button
    }()

    override func viewDidLoad() {
        self.configure()
        self.binding()
    }

}

private extension PopoverViewController {
    func configure() {
        self.view.backgroundColor = .systemGray6
        self.configureHierarchy()
        self.configureConstraint()
    }

    func configureHierarchy() {
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(topButton)
        self.stackView.addArrangedSubview(bottomButton)
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            self.stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            self.stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    func binding() {
        let input = PopoverViewModel.Input(
            topButtonDidTap: self.topButton.rx.tap.asObservable(),
            bottomButtonDidTap: self.bottomButton.rx.tap.asObservable(),
            viewDidDisappear: self.rx.methodInvoked(#selector(UIViewController.viewDidDisappear))
                .map { _ in }
        )
        guard let output = self.viewModel?.transform(input: input, disposeBag: bag) else { return }

        output.topButtonTitleText.asDriver()
            .drive(self.topButton.rx.title())
            .disposed(by: bag)

        output.bottomButtonTitleText.asDriver()
            .drive(self.bottomButton.rx.title())
            .disposed(by: bag)
    }
}
