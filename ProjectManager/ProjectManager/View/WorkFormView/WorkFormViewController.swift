import UIKit
import RxSwift


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
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    private let buttonPressObserver: PublishSubject<(String?, Date, String)> = .init()
    private let viewDidLoadObserver: PublishSubject<Void> = .init()
    private var disposeBag = DisposeBag()
    private var viewModel = WorkFormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupTextView()
        viewDidLoadObserver.onNext(())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    func setup(selectedWork: Work?, list: BehaviorSubject<[Work]>?, workMemoryManager: WorkMemoryManager?) {
        guard let list = list,
              let workMemoryManager = workMemoryManager else {
                  return
              }
        
        self.viewModel.setup(
            selectedWork: selectedWork,
            list: list,
            workMemoryManager: workMemoryManager
        )
    }
    
    private func bind() {
        let input = WorkFormViewModel.Input(
            buttonPressObserver: buttonPressObserver.asObservable(),
            viewDidLoadObserver: viewDidLoadObserver.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        configureFillContentObserver(output)
        configureShowRightBarButtonItemObserver(output)
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
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction private func touchUpRightBarButton(_ sender: UIBarButtonItem) {
        buttonPressObserver.onNext((titleTextField.text, datePicker.date, bodyTextView.text))
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
        configureTextViewShadow()
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
