//
//  NewToDoView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class NewToDoView: UIView {
    
    private lazy var formSheetStackView = UIStackView(
        arrangedSubviews: [
        titleTextField,
        datePicker,
        descriptionTextView
        ]).then {
            $0.axis = .vertical
            $0.spacing = 5
    }
    
    private lazy var titleTextField = UITextField().then {
        $0.placeholder = "Title"
        $0.addLeftPadding()
        setShadow(target: $0)
    }
    
    private lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
    }
    
    private lazy var descriptionTextView = UITextView().then {
        $0.font = .preferredFont(forTextStyle: .subheadline)
        $0.text = "입력 가능한 글자수는 1000자로 제한합니다."
        setShadow(target: $0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setShadow(target: UIView) {
        target.layer.borderWidth = 1
        target.layer.borderColor = UIColor.gray.cgColor
        target.layer.shadowOpacity = 1
        target.layer.shadowRadius = 5
        target.layer.shadowColor = UIColor.gray.cgColor
        target.layer.shadowOffset = .init(width: 0, height: 3)
    }
    
    private func setupUILayout() {
        addSubview(formSheetStackView)
        formSheetStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(15)
        }
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(formSheetStackView.snp.height).multipliedBy(0.1)
        }
    }
}
