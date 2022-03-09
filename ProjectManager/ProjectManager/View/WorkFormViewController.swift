import UIKit


private enum Design {
    static let shadowColor: CGColor = UIColor.black.cgColor
    static let shadowOffset = CGSize(width: 0, height: 5)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 5.0
    
    static let textInputBackgroundColor = UIColor.white.cgColor
    static let textFieldLeftPadding: CGFloat = 10
}

final class WorkFormViewController: UIViewController {
    
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
        titleTextField.layer.backgroundColor = Design.textInputBackgroundColor
        
        titleTextField.layer.shadowColor = Design.shadowColor
        titleTextField.layer.shadowOffset = Design.shadowOffset
        titleTextField.layer.shadowOpacity = Design.shadowOpacity
        titleTextField.layer.shadowRadius = Design.shadowRadius
    }
    
    private func configureTextFieldLeftView() {
        let leftView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: Design.textFieldLeftPadding,
            height: titleTextField.frame.height
        ))
        titleTextField.leftView = leftView
        titleTextField.leftViewMode = .always
    }
    
    private func configureTextViewShadow() {
        bodyTextView.layer.masksToBounds = false
        
        bodyTextView.layer.backgroundColor = Design.textInputBackgroundColor
        
        bodyTextView.layer.shadowColor = Design.shadowColor
        bodyTextView.layer.shadowOffset = Design.shadowOffset
        bodyTextView.layer.shadowOpacity = Design.shadowOpacity
        bodyTextView.layer.shadowRadius = Design.shadowRadius
    }
    
}
