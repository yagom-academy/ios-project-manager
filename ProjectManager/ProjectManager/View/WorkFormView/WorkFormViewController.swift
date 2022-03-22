import UIKit
import RxSwift


private enum Content {
    
    static let emptyBody = "입력가능한 글자수는 1000자로 제한합니다."
    static let editTitle = "Edit"
    static let doneTitle = "Done"
    
}

private enum Design {
    static let shadowColor: CGColor = UIColor.black.cgColor
    static let shadowOffset = CGSize(width: 0, height: 5)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 5.0
    
    static let textInputBackgroundColor = UIColor.white.cgColor
    static let textFieldLeftPadding: CGFloat = 10
}

final class WorkFormViewController: UIViewController {
    
    @IBOutlet weak private var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    private let buttonPressObserver: PublishSubject<(String?, Date, String)> = .init()
    private let viewDidLoadObserver: PublishSubject<Void> = .init()
    private let textViewEditObserver: PublishSubject<String> = .init()
    
    private var disposeBag = DisposeBag()
    private var viewModel = WorkFormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObserver()
        setupTextField()
        setupTextView()
        viewDidLoadObserver.onNext(())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    func setup(selectedWork: Work?, list: BehaviorSubject<[Work]>) {
        self.viewModel.setup(
            selectedWork: selectedWork,
            list: list
        )
    }
    
    @IBAction private func touchUpRightBarButton(_ sender: UIBarButtonItem) {
        buttonPressObserver.onNext((titleTextField.text, datePicker.date, bodyTextView.text))
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func bind() {
        let input = WorkFormViewModel.Input(
            buttonPressObserver: buttonPressObserver.asObservable(),
            viewDidLoadObserver: viewDidLoadObserver.asObservable(),
            textViewEditObserver: textViewEditObserver.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        configureFillContentObserver(output)
        configureShowRightBarButtonItemObserver(output)
        configureTextViewPlaceholderObserver(output)
    }
    
    private func configureFillContentObserver(_ output: WorkFormViewModel.Output) {
        output
            .fillContentObserver
            .subscribe(onNext: { [weak self] (title, date, body) in
                guard let date = date else { return }
                
                self?.titleTextField.text = title
                self?.datePicker.date = date
                self?.bodyTextView.text = body
            })
            .disposed(by: disposeBag)
    }
    
    private func configureShowRightBarButtonItemObserver(_ output: WorkFormViewModel.Output) {
        output
            .showRightBarButtonItemObserver
            .subscribe(onNext: { [weak self] in
                self?.rightBarButtonItem.title = $0
                
                if $0 == Content.editTitle {
                    self?.bodyTextView.textColor = .label
                } else if $0 == Content.doneTitle {
                    self?.bodyTextView.textColor = .placeholderText
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTextViewPlaceholderObserver(_ output: WorkFormViewModel.Output) {
        output
            .textViewPlaceholderObserver
            .subscribe(onNext: { [weak self] in
                self?.bodyTextView.text = Content.emptyBody
                self?.bodyTextView.textColor = .placeholderText
            })
            .disposed(by: disposeBag)
    }
    
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let bottomContentInset = keyboardFrame.cgRectValue.height
        
        contentScrollView.contentInset.bottom = bottomContentInset
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        contentScrollView.contentInset.bottom = .zero
    }
    
    private func setupTextField() {
        configureTextFieldShadow()
        configureTextFieldLeftView()
    }
    
    private func configureTextFieldShadow() {
        titleTextField.layer.backgroundColor = Design.textInputBackgroundColor
        makeShadow(for: titleTextField)
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
    
    private func setupTextView() {
        configureTextViewDelegate()
        configureTextViewShadow()
    }
    
    private func configureTextViewDelegate() {
        bodyTextView.delegate = self
    }
    
    private func configureTextViewShadow() {
        bodyTextView.layer.masksToBounds = false
        bodyTextView.layer.backgroundColor = Design.textInputBackgroundColor
        makeShadow(for: bodyTextView)
    }
    
    private func makeShadow(for view: UIView) {
        view.layer.shadowColor = Design.shadowColor
        view.layer.shadowOffset = Design.shadowOffset
        view.layer.shadowOpacity = Design.shadowOpacity
        view.layer.shadowRadius = Design.shadowRadius
    }
    
}

extension WorkFormViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let hasOnlyPlaceholder: Bool = textView.textColor == .placeholderText
        
        if hasOnlyPlaceholder {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewEditObserver.onNext(textView.text)
    }
    
}
