import UIKit

class AddTodoViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return stackView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = true
        textView.clipsToBounds = false
        textView.layer.shadowRadius = 5.0
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowOffset = CGSize(width: 3, height: 3)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStackView()
        setNavigation()
        setAutoLayout()
    }
    
    private func setStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
    }
    
    private func setNavigation() {
        navigationItem.title = "TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTappedDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTappedCancelButton))
    }
    
    @objc private func didTappedDoneButton() {
        
    }
    
    @objc private func didTappedCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
}
