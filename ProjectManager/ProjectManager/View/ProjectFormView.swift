import UIKit

class ProjectFormView: UIView {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = Text.textFieldPlaceholder
        textField.layer.borderWidth = Design.borderWidth
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
        textView.layer.borderWidth = Design.borderWidth
        textView.layer.borderColor = UIColor.systemGray2.cgColor
        
        return textView
    }()
    
    private lazy var formStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, detailTextView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Design.stackViewSpacing
        titleTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        detailTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func getDateFromPicker() -> Date {
        return datePicker.date
    }
    
    private func commonInit() {
        backgroundColor = .systemBackground
        setupFormStackViewLayout()
    }
    
    private func setupFormStackViewLayout() {
        addSubview(formStackView)
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: topAnchor, constant: Design.stackViewMargin),
            formStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Design.stackViewMargin),
            formStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Design.stackViewMargin),
            formStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Design.stackViewMargin),
        ])
    }
}

private enum Text {
    static let textFieldPlaceholder = "Title"
}

private enum Design {
    static let borderWidth: CGFloat = 1
    static let stackViewSpacing: CGFloat = 10
    static let stackViewMargin: CGFloat = 10
}
