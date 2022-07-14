//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/13.
//

import UIKit
import SnapKit
import RxSwift

final class TodoMoveViewController: UIViewController {
    let item: TodoModel
    
    let viewModel: TodoMoveViewModel
    let bag = DisposeBag()
    
    let firstButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.backgroundColor = .systemBackground
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.backgroundColor = .systemBackground
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var buttomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton, secondButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init(viewModel: TodoMoveViewModel, item: TodoModel) {
        self.viewModel = viewModel
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
        viewModel.setbuttonTitle(state: item.state)
    }
    
    func configureView() {
        view.backgroundColor = .systemGray5
        view.addSubview(buttomStackView)
        buttomStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
    }
}

extension TodoMoveViewController {
    private func bind() {
        viewModel.buttonTitle
            .bind { [weak self] (firstTitle, secondTitle) in
                self?.firstButton.setTitle(firstTitle, for: .normal)
                self?.secondButton.setTitle(secondTitle, for: .normal)
            }.disposed(by: bag)
    }
}
