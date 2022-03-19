import Foundation
import RxSwift


private enum Content {
    
    static let emptyString = ""
    static let emptyTitle = "제목을 입력해주세요"
    
    static let editTitle = "Edit"
    static let doneTitle = "Done"
    
}

class WorkFormViewModel: ViewModelDescribing {
    
    final class Input {
        
        let buttonPressObserver: Observable<(String?, Date, String)>
        let viewDidLoadObserver: Observable<Void>
        
        init(buttonPressObserver: Observable<(String?, Date, String)>,
             viewDidLoadObserver: Observable<Void>
        ) {
            self.buttonPressObserver = buttonPressObserver
            self.viewDidLoadObserver = viewDidLoadObserver
        }
        
    }
    
    final class Output {
        let fillContentObserver: Observable<(String?, Date?, String?)>
        let showRightBarButtonItemObserver: Observable<String>
        
        init(fillContentObserver: Observable<(String?, Date?, String?)>,
             showRightBarButtonItemObserver: Observable<String>
        ) {
            self.fillContentObserver = fillContentObserver
            self.showRightBarButtonItemObserver = showRightBarButtonItemObserver
        }
    }
    
    private(set) var selectedWork: Work?
    private(set) var workMemoryManager: WorkMemoryManager!
    private var list = BehaviorSubject<[Work]>(value: [])
    private let disposeBag = DisposeBag()
    
    func setup(selectedWork: Work?, list: BehaviorSubject<[Work]>, workMemoryManager: WorkMemoryManager) {
        self.selectedWork = selectedWork
        self.list = list
        self.workMemoryManager = workMemoryManager
    }
    
    func transform(_ input: Input) -> Output {
        let fillContentObserver = PublishSubject<(String?, Date?, String?)>()
        let showRightBarButtonItemObserver = PublishSubject<String>()
        
        configureButtonPressObserver(by: input)
        configureViewDidLoadObserver(by: input, observer: fillContentObserver)
        configureViewDidLoadObserver(by: input, observer: showRightBarButtonItemObserver)
        
        let output = Output(
            fillContentObserver: fillContentObserver,
            showRightBarButtonItemObserver: showRightBarButtonItemObserver
        )
        
        return output
    }
    
    private func configureButtonPressObserver(by input: Input) {
        input
            .buttonPressObserver
            .bind(onNext: { [weak self] (title, dueDate, body) in
                if self?.selectedWork == nil {
                    guard let title = title else {
                        self?.addWork(title: Content.emptyTitle, dueDate: dueDate, body: body)
                        return
                    }
                    self?.addWork(title: title, dueDate: dueDate, body: body)
                } else {
                    self?.updateWork(title: title, dueDate: dueDate, body: body)
                }
            })
            .disposed(by: disposeBag)
            
    }
    
    private func addWork(title: String, dueDate: Date, body: String) {
        let work = Work(title: title, body: body, dueDate: dueDate, category: .todo)
        
        workMemoryManager?.create(work)
        list.onNext(workMemoryManager.todoList)
    }
    
    func updateWork(title: String?, dueDate: Date?, body: String?) {
        guard let selectedWork = selectedWork else { return }
        
        workMemoryManager.update(selectedWork, title: title, body: body, date: dueDate, category: selectedWork.category)
        
        switch selectedWork.category {
        case .todo:
            list.onNext(workMemoryManager.todoList)
        case .doing:
            list.onNext(workMemoryManager.doingList)
        case .done:
            list.onNext(workMemoryManager.doneList)
        }
    }
    
    private func configureViewDidLoadObserver(by input: Input, observer: PublishSubject<(String?, Date?, String?)>) {
        input
            .viewDidLoadObserver
            .bind(onNext: { [weak self] in
                observer.onNext((self?.selectedWork?.title, self?.selectedWork?.dueDate, self?.selectedWork?.body))
            })
            .disposed(by: disposeBag)
    }
    
    private func configureViewDidLoadObserver(by input: Input, observer: PublishSubject<String>) {
        input
            .viewDidLoadObserver
            .bind(onNext: { [weak self] in
                if self?.selectedWork == nil {
                    observer.onNext(Content.doneTitle)
                } else {
                    observer.onNext(Content.editTitle)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
