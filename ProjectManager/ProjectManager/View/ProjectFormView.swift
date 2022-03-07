import UIKit

class ProjectFormView: UIView {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = "Title"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
        
        return datePicker
    }()
    
    private let detailTextView: UITextView = {
        let textView = UITextView()
        textView.text = "안녕하세요 앨리입니다. 당근마켓 가고시퍼요,,"
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray2.cgColor
        
        return textView
    }()
    
    private lazy var formStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, detailTextView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        titleTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        detailTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupFormStackViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFormStackViewLayout() {
        addSubview(formStackView)
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            formStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            formStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            formStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func getDateFromPicker() -> Date {
        return datePicker.date
    }
}
