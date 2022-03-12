import UIKit

class ProjectAddViewController: UIViewController {
    
    private let textfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "Input Name Here"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let datePicker: UIDatePicker = {
        let datepicker = UIDatePicker(frame: .zero)
        datepicker.datePickerMode = .date
        datepicker.translatesAutoresizingMaskIntoConstraints = false
        return datepicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.textfield,
                self.datePicker,
                self.textView
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        view.addSubview(self.stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }

}
