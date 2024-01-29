//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by Toy on 1/25/24.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    // MARK: - Property
    static let identifier = String(describing: ListViewController.self)
    // text 는 테스트용으로 설정하였습니다.
    // 다음 스텝에서 수정하겠습니다.
    private let titleLabel = {
        let label = UILabel()
        label.text = "title testbody testbody testbody testbody testbody testbody testbody testbody testbody test"
        label.font = UIFont.systemFont(ofSize: 22)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let bodyLabel = {
        let label = UILabel()
        label.text = """
                    body testbody testbodybody testbody testbodybody testbody testbodybody testbody testbodybody testbody testbodybody testbody testbody
                    """
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "2024. 01. 25. test"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let lineOfSapcingView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    private let spacingOfRowView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
        view.heightAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    
    private let labelStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let spacingStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Helper
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLabelStackView()
        setupSpacingStackView()
    }
    
    private func setupConstraints() {
        setupSpacingStackViewConstraint()
        setupLabelStackViewConstraint()
    }
    
    private func setupLabelStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(bodyLabel)
        labelStackView.addArrangedSubview(dateLabel)
        contentView.addSubview(labelStackView)
    }
    
    private func setupLabelStackViewConstraint() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: spacingStackView.bottomAnchor, constant: 10),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupSpacingStackView() {
        spacingStackView.addArrangedSubview(lineOfSapcingView)
        spacingStackView.addArrangedSubview(spacingOfRowView)
        contentView.addSubview(spacingStackView)
    }
    
    private func setupSpacingStackViewConstraint() {
        NSLayoutConstraint.activate([
            spacingStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            spacingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
