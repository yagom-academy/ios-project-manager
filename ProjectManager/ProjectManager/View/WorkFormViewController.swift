import UIKit

class WorkFormViewController: UIViewController {
    
    private var viewModel: ProjectViewModel?
    
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    convenience init?(coder: NSCoder, viewModel: ProjectViewModel) {
        self.init(coder: coder)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupTextView()
    }
    
    @IBAction private func touchUpDoneButton(_ sender: UIBarButtonItem) {
        guard let viewModel = viewModel else { return }
        let work = Work(title: titleTextField.text, body: bodyTextView.text, dueDate: datePicker.date)
        viewModel.addWork(work)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTextField() {
        configureTextFieldShadow()
        configureTextFieldLeftView()
    }
    
    private func setupTextView() {
        configureTextViewShadow()
    }
    
    private func configureTextFieldShadow() {
        titleTextField.layer.backgroundColor = UIColor.white.cgColor
        
        titleTextField.layer.shadowColor = UIColor.black.cgColor
        titleTextField.layer.shadowOffset = CGSize(width: 0, height: 5)
        titleTextField.layer.shadowOpacity = 0.3
        titleTextField.layer.shadowRadius = 5.0
    }
    
    private func configureTextFieldLeftView() {
        let leftView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: 10,
            height: titleTextField.frame.height
        ))
        titleTextField.leftView = leftView
        titleTextField.leftViewMode = .always
    }
    
    private func configureTextViewShadow() {
        bodyTextView.layer.masksToBounds = false
        
        bodyTextView.layer.backgroundColor = UIColor.white.cgColor
        
        bodyTextView.layer.shadowColor = UIColor.black.cgColor
        bodyTextView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bodyTextView.layer.shadowOpacity = 0.3
        bodyTextView.layer.shadowRadius = 5.0
    }
    
}
