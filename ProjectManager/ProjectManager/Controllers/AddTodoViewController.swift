import UIKit

class AddTodoViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .white
        stackView.alignment = .center
        return stackView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        
//        textField.layer.borderColor = UIColor.gray.cgColor
//        textField.layer.borderWidth = 0.5
        textField.clipsToBounds = false // todo: shadow refactoring
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOpacity = 0.5
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
        stackView.frame = view.bounds
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
        let magin: CGFloat = 10
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: magin),
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: magin),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -magin),
            
            textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: magin),
            textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -magin),
            textView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -magin),
            
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: magin),
            datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -magin)
        ])
    }
}
