//
//  ProjectCell.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit
import RxSwift

final class ProjectCell: UITableViewCell {
    let onData: AnyObserver<ProjectContents>
    let disposeBag = DisposeBag()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    init() {
        let data = PublishSubject<ProjectContents>()
        self.onData = data.asObserver()
        
        super.init(style: .default, reuseIdentifier: "\(ProjectCell.self)")
        
        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] content in
                self?.compose(
                    title: content.title,
                    description: content.description,
                    date: content.deadline
                )
            })
            .disposed(by: disposeBag)
        
        setUpCell()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        baseStackView.addArrangedSubview(titleLabel)
        baseStackView.addArrangedSubview(descriptionLabel)
        baseStackView.addArrangedSubview(dateLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func compose(title: String, description: String, date: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        dateLabel.text = date
    }
}
