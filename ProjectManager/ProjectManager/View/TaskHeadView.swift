//
//  HeadView.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/03.
//

import UIKit
import SnapKit

final class TaskHeadView: UIView {
    private let classificationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private let countNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()

    init(classification: String) {
        super.init(frame: .zero)
        classificationLabel.text = classification
        self.backgroundColor = .systemGray
        setLabel()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setLabel() {
        self.addSubview(classificationLabel)
        self.addSubview(countNumberLabel)

        classificationLabel.snp.makeConstraints { label in
            label.centerY.equalTo(self.safeAreaLayoutGuide)
            label.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            label.leading.equalTo(self.safeAreaLayoutGuide).inset(15)

        }

        countNumberLabel.snp.makeConstraints { label in
            label.centerY.equalTo(self.safeAreaLayoutGuide)
            label.leading.equalTo(classificationLabel.snp.trailing).offset(10)
            label.width.height.equalTo(25)
        }
    }

    func setCountNumberLabelText(countNumber: String) {
        countNumberLabel.text = countNumber
    }
}
