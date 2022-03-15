import UIKit
import RxCocoa
import RxSwift

enum Placeholder {
    static let title = "Title"
    static let body = "여기는 할일 내용을 입력하는 곳이지롱\n입력 가능한 글자수는 1000자로 제한합니다."
}

class DetailViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var rightBarButton: UIBarButtonItem!
    @IBOutlet private weak var leftBarButton: UIBarButtonItem!
    
    var viewModel: DetailViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUpBindings()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.dismiss()
        viewModel = nil
    }
    
    private func configure() {
        titleTextField.placeholder = Placeholder.title
        
        descriptionTextView.rx.didEndEditing
            .withUnretained(self).subscribe(onNext: { owner, _ in
                if owner.descriptionTextView.text.isEmpty {
                    owner.descriptionTextView.text = Placeholder.body
                }
            }).disposed(by: disposeBag)
        descriptionTextView.rx.didBeginEditing
            .withUnretained(self).subscribe(onNext: { owner, _ in
                if owner.descriptionTextView.text == Placeholder.body {
                    owner.descriptionTextView.text = nil
                }
            }).disposed(by: disposeBag)
    }
    
    private func setUpBindings() {
        let input = DetailViewModel.Input(
            didTapRightBarButton: rightBarButton.rx.tap.asObservable(),
            didTapLeftBarButton: leftBarButton.rx.tap.asObservable(),
            didChangeTitleText: titleTextField.rx.text.changed.asObservable(),
            didChangeDatePicker: datePicker.rx.date.changed.asObservable(),
            didChangeDescription: descriptionTextView.rx.text.changed.asObservable())
        
        let output = viewModel?.transform(input: input, disposeBag: disposeBag)
        
        output?.isEditable
            .bind(to:
                titleTextField.rx.isEnabled.asObserver(),
                datePicker.rx.isEnabled.asObserver(),
                descriptionTextView.rx.isEditable.asObserver()
            )
            .disposed(by: disposeBag)
        
        output?.leftBarButtonText
            .bind(to: leftBarButton.rx.title)
            .disposed(by: disposeBag)
        
        output?.projectTitle
            .bind(to: titleTextField.rx.text)
            .disposed(by: disposeBag)
    
        output?.projectDate
            .bind(to: datePicker.rx.date)
            .disposed(by: disposeBag)
       
        output?.projectDescription
            .bind(to: descriptionTextView.rx.text)
            .disposed(by: disposeBag)
    
        output?.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output?.isDescriptionTextValid
            .bind(to: rightBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
