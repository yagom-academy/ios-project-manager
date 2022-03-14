import UIKit

class ProjectDetailView: UIView {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = Placeholder.titleTextFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.dropShadow(
            shadowColor: UIColor.black.cgColor,
            shadowOffset: Design.shadowOffset,
            shadowOpacity: Design.shadowOpacity,
            shadowRadius: Design.shadowRadius)
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "여기에는 할일 내용 입력하는 곳이지롱 \nㅋㅋ"
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = Design.borderWidth
        textView.layer.cornerRadius = Design.cornerRadius
        textView.dropShadow(
            shadowColor: UIColor.black.cgColor,
            shadowOffset: Design.shadowOffset,
            shadowOpacity: Design.shadowOpacity,
            shadowRadius: Design.shadowRadius)
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        backgroundColor = .white
        addSubview(entireScrollView)
        entireScrollView.addSubview(entireStackView)
        configureEntireStackView()
        configureLayout()
    }
    
    private func configureEntireStackView() {
        [titleTextField, datePicker, bodyTextView].forEach {
            entireStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.entireScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: LayoutConstant.entireScrollViewTrailingMargin),
            self.entireScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: LayoutConstant.entireScrollViewBottomMargin),
            self.entireScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstant.entireScrollViewLeadingMargin),
            self.entireStackView.topAnchor.constraint(equalTo: self.entireScrollView.contentLayoutGuide.topAnchor, constant: LayoutConstant.entireStackViewTopMargin),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.entireScrollView.contentLayoutGuide.trailingAnchor),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.entireScrollView.contentLayoutGuide.bottomAnchor),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.entireScrollView.contentLayoutGuide.leadingAnchor),
            self.entireStackView.widthAnchor.constraint(equalTo: self.entireScrollView.frameLayoutGuide.widthAnchor),
            self.titleTextField.heightAnchor.constraint(equalToConstant: LayoutConstant.titleTextFieldHeight)
        ])
    }
    
    func populateData(with data: Project?) {
        guard let date = data?.date else {
            return
        }
        titleTextField.text = data?.title
        bodyTextView.text = data?.body
        datePicker.setDate(date, animated: true)
    }
    
    func setEditingMode(to state: Bool) {
        titleTextField.isEnabled = state
        bodyTextView.isEditable = state
        datePicker.isUserInteractionEnabled = state
    }
    
    func createViewData() -> Project {
        return Project(
            id: UUID(),
            state: .todo,
            title: titleTextField.text ?? "",
            body: bodyTextView.text ?? "",
            date: datePicker.date)
    }
    
    func retrieveViewData(with oldProject: Project) -> Project {
        return Project(
            id: oldProject.id,
            state: oldProject.state,
            title: titleTextField.text ?? "",
            body: bodyTextView.text ?? "",
            date: datePicker.date)
    }
}

//MARK: - Constants

private extension ProjectDetailView {
    enum Placeholder {
        static let titleTextFieldPlaceholder = "Title"
    }

    enum LayoutConstant {
        static let entireScrollViewTrailingMargin: CGFloat = -10
        static let entireScrollViewBottomMargin: CGFloat = -10
        static let entireScrollViewLeadingMargin: CGFloat = 10
        static let entireStackViewTopMargin: CGFloat = 5
        static let titleTextFieldHeight: CGFloat = 50
    }

    enum Design {
        static let cornerRadius: CGFloat = 5
        static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 4
        static let borderWidth: CGFloat = 1
    }
}
