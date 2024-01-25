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
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupStackViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Helper
    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        self.addSubview(stackView)
    }
    
    private func setupStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
}
