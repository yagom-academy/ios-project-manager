import UIKit

class ProjectDetailViewController: UIViewController {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = "Title"
        textField.dropShadow(
            cornerRadius: 5.0,
            backgroundColor: UIColor.white.cgColor,
            borderColor: UIColor.clear.cgColor,
            shadowColor: UIColor.black.cgColor,
            shadowOffset: CGSize(width: 0, height: 3),
            shadowOpacity: 0.5,
            shadowRadius: 4.0)
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
            cornerRadius: 5.0,
            backgroundColor: UIColor.white.cgColor,
            borderColor: UIColor.clear.cgColor,
            shadowColor: UIColor.black.cgColor,
            shadowOffset: CGSize(width: 0, height: 3),
            shadowOpacity: 0.5,
            shadowRadius: 4.0)
        return textView
    }()
    
    private lazy var entireStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, bodyTextView])
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
        configureLayout()
        configureNavigationBar()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
}
