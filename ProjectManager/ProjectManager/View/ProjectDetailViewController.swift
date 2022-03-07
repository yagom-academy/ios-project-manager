import UIKit

class ProjectDetailViewController: UIViewController {
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
        textView.dropShadow(
            shadowColor: UIColor.black.cgColor,
            shadowOffset: Design.shadowOffset,
            shadowOpacity: Design.shadowOpacity,
            shadowRadius: Design.shadowRadius)
        return textView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        self.view.addSubview(entireStackView)
        configureEntireStackView()
        configureLayout()
        configureNavigationBar()
    }
    
    private func configureEntireStackView() {
        [titleTextField, datePicker, bodyTextView].forEach {
            entireStackView.addArrangedSubview($0)
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstant.entireStackViewTopMargin),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: LayoutConstant.entireStackViewtrailingMargin),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: LayoutConstant.entireStackViewBottomMargin),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: LayoutConstant.entireStackViewLeadingMargin),
            self.titleTextField.heightAnchor.constraint(equalToConstant: LayoutConstant.titleTextFieldHeight)
        ])
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDoneButton))
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constants

private extension ProjectDetailViewController {
    enum Placeholder {
        static let titleTextFieldPlaceholder = "Title"
    }

    enum TitleText {
        static let navigationBarTitle = "TODO"
    }

    enum LayoutConstant {
        static let entireStackViewTopMargin: CGFloat = 5
        static let entireStackViewtrailingMargin: CGFloat = -20
        static let entireStackViewBottomMargin: CGFloat = -20
        static let entireStackViewLeadingMargin: CGFloat = 20
        static let titleTextFieldHeight: CGFloat = 50
    }

    enum Design {
        static let cornerRadius: CGFloat = 5
        static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 4
    }
}
