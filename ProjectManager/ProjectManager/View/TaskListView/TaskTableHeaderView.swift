import UIKit
import RxSwift
import RxCocoa

class TaskTableHeaderView: UITableViewHeaderFooterView {
    var taskCountObservable: Observable<Int>
    var processStatus: ProcessStatus
    var disposeBag = DisposeBag()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    var taskCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    init(reuseIdentifier: String?, taskCountObservable: Observable<Int>, processStatus: ProcessStatus) { // ViewModel 간 의존성은 어떻게 처리?
        self.taskCountObservable = taskCountObservable
        self.processStatus = processStatus
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupFrame()
        setupLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        let inset = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(taskCountLabel)
    }
    
    private func setupFrame() {
        let height = 50.0
        self.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: height) 
    }
    
    func setupLabels() {
        titleLabel.text = processStatus.description
        
        taskCountObservable
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(taskCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
