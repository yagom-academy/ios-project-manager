//
//  PopupViewController.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/19.
//
//

import UIKit
import SnapKit

class PopupViewController: UIViewController {
    private var navigationBar = UINavigationBar()
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let titleTextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요"
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    private let datePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.preferredDatePickerStyle = .wheels
        return date
    }()
    
    private let contentTextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 4)
        textView.layer.shadowRadius = 5
        textView.layer.shadowOpacity = 0.3
        return textView
    }()
    
    private let popupStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.addSubview(containerView)
        containerView.addSubview(navigationBar)
        containerView.addSubview(popupStackView)
        
        popupStackView.addArrangedSubview(titleTextField)
        popupStackView.addArrangedSubview(datePicker)
        popupStackView.addArrangedSubview(contentTextView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        popupStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configureNavigation() {
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: containerView.frame.width, height: 44))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationBar.setItems([UINavigationItem(title: "TODO")] , animated: false)
    }
    
    @objc private func didTapDoneButton() {
    
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
    
}

//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    // curveEaseOut: 시작은 천천히, 끝날 땐 빠르게
//    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
//        self?.containerView.transform = .identity
//        self?.containerView.isHidden = false
//    }
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//
//    // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
//    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
//        self?.containerView.transform = .identity
//        self?.containerView.isHidden = true
//    }
//}

