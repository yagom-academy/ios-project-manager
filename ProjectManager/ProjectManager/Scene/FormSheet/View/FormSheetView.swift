//
//  FormSheetView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import SnapKit

final class FormSheetView: UIView {
    
    fileprivate enum Constants {
        static let titlePlaceholder: String = "Title"
        static let bodyDefaultValue: String = "입력 가능한 글자수는 1000자로 제한합니다."
    }
    
    private lazy var formSheetStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private(set) lazy var titleTextField = UITextField().then {
        $0.placeholder = Constants.titlePlaceholder
        $0.backgroundColor = .white
        $0.addLeftPadding()
        setShadow(target: $0)
    }
    
    private(set) lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
    }
    
    private lazy var shadowView = UIView().then {
        $0.backgroundColor = .white
        setShadow(target: $0)
    }
    
    private(set) lazy var bodyTextView = UITextView().then {
        $0.font = .preferredFont(forTextStyle: .subheadline)
        $0.text = Constants.bodyDefaultValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setShadow(target: UIView) {
        target.layer.borderWidth = 0.5
        target.layer.borderColor = UIColor.gray.cgColor
        target.layer.shadowOpacity = 0.5
        target.layer.shadowRadius = 5
        target.layer.shadowColor = UIColor.gray.cgColor
        target.layer.shadowOffset = .init(width: 0, height: 3)
    }
    
    private func setupSubViews() {
        addSubview(formSheetStackView)
        
        formSheetStackView.addArrangedSubview(titleTextField)
        formSheetStackView.addArrangedSubview(datePicker)
        formSheetStackView.addArrangedSubview(shadowView)
        
        shadowView.addSubview(bodyTextView)
    }
    
    private func setupUILayout() {
        
        bodyTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        formSheetStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(30)
        }
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(formSheetStackView.snp.height).multipliedBy(0.1)
        }
    }
    
    func setUpContents(task: Task) {
        titleTextField.text = task.title
        datePicker.date = Date.init(timeIntervalSince1970: task.date)
        bodyTextView.text = task.body
    }
}
