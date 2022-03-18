import Foundation
import RxSwift


private enum Content {

    static let moveToDoTitle = "Move to TODO"
    static let moveDoingTitle = "Move to DOING"
    static let moveDoneTitle = "Move to DONE"
    
}

class ProjectTableViewModel: ViewModelDescribing {
    
    final class Input {
        
        let viewDidLoadObserver: Observable<Void>
        let cellLongPressedObserver: Observable<IndexPath>
        let swipeActionObserver: Observable<IndexPath>
        let didSelectedObserver: Observable<IndexPath>
        let popoverActionObserver: Observable<(String, Work)>
        
        init(
            viewDidLoadObserver: Observable<Void>,
            cellLongPressedObserver: Observable<IndexPath>,
            swipeActionObserver: Observable<IndexPath>,
            didSelectedObserver: Observable<IndexPath>,
            popoverActionObserver: Observable<(String, Work)>
        ) {
            self.viewDidLoadObserver = viewDidLoadObserver
            self.cellLongPressedObserver = cellLongPressedObserver
            self.swipeActionObserver = swipeActionObserver
            self.didSelectedObserver = didSelectedObserver
            self.popoverActionObserver = popoverActionObserver
        }
        
    }
    
    final class Output {
        
        let setupPlaceholderObserver: Observable<[Work]>
        let showPopoverObserver: Observable<Work>
        let showWorkFormViewObserver: Observable<Work>
        
        init(
            setPlaceholderObserver: Observable<[Work]>,
            showPopoverObserver: Observable<Work>,
            showWorkFormViewObserver: Observable<Work>
        ) {
            self.setupPlaceholderObserver = setPlaceholderObserver
            self.showPopoverObserver = showPopoverObserver
            self.showWorkFormViewObserver = showWorkFormViewObserver
        }
        
    }
    
    private(set) var titleText: String?
    private(set) var count: Observable<Int>?
    private(set) var list = BehaviorSubject<[Work]>(value: [])
    private(set) var workMemoryManager: WorkMemoryManager!
    private var projectViewModel: ProjectViewModel?
    private let disposeBag = DisposeBag()
    
    func setup(
        titleText: String,
        count: Observable<Int>,
        list: BehaviorSubject<[Work]>,
        workMemoryManager: WorkMemoryManager,
        projectViewModel: ProjectViewModel
    ) {
        self.titleText = titleText
        self.count = count
        self.list = list
        self.workMemoryManager = workMemoryManager
        self.projectViewModel = projectViewModel
    }
    
    func transform(_ input: Input) -> Output {
        let setupPlaceholderObserver = PublishSubject<[Work]>()
        let showPopoverObserver = PublishSubject<Work>()
        let showWorkFormViewObserver = PublishSubject<Work>()
        
        configureViewDidLoadObserver(by: input, observer: setupPlaceholderObserver)
        configureCellLongPressedObserver(by: input, observer: showPopoverObserver)
        configureSwipeActionObserver(by: input)
        configureDidSelectedObserver(by: input, observer: showWorkFormViewObserver)
        configurePopoverActionObserver(by: input)
       
        let output = Output(
            setPlaceholderObserver: setupPlaceholderObserver.asObservable(),
            showPopoverObserver: showPopoverObserver.asObservable(),
            showWorkFormViewObserver: showWorkFormViewObserver.asObservable()
        )
        
        return output
    }
    
    private func configureViewDidLoadObserver(by input: Input, observer: PublishSubject<[Work]>) {
        input
            .viewDidLoadObserver
            .bind(onNext: { [weak self] _ in
                guard let list = self?.list else { return }
                
                _ = list.subscribe(onNext: {
                    observer.onNext($0)
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func configureCellLongPressedObserver(by input: Input, observer: PublishSubject<Work>) {
        input
            .cellLongPressedObserver
            .bind(onNext: { [weak self] (indexPath) in
                guard let list = self?.list else { return }
                guard let targetWork = try? list.value()[safe: indexPath.row] else {
                    return
                }
                
                observer.onNext(targetWork)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureSwipeActionObserver(by input: Input) {
        input
            .swipeActionObserver
            .bind(onNext: { [weak self] (indexPath) in
                guard let list = self?.list else { return }
                guard let targetWork = try? list.value()[safe: indexPath.row] else {
                    return
                }

                self?.removeWork(targetWork)
            })
            .disposed(by: disposeBag)
    }
    
    private func removeWork(_ data: Work) {
        guard let workMemoryManager = workMemoryManager else { return }
        
        workMemoryManager.delete(data)
        
        switch data.category {
        case .todo:
            list.onNext(workMemoryManager.todoList)
        case .doing:
            list.onNext(workMemoryManager.doingList)
        case .done:
            list.onNext(workMemoryManager.doneList)
        }
    }
    
    private func configureDidSelectedObserver(by input: Input, observer: PublishSubject<Work>) {
        input
            .didSelectedObserver
            .subscribe(onNext: { [weak self] indexPath in
                guard let list = self?.list else { return }
                guard let targetWork = try? list.value()[safe: indexPath.row] else {
                    return
                }
                observer.onNext(targetWork)
            })
            .disposed(by: disposeBag)
    }
    
    private func configurePopoverActionObserver(by input: Input) {
        input
            .popoverActionObserver
            .bind(onNext: { (title, work) in
                switch title {
                case Content.moveToDoTitle:
                    self.change(work, category: .todo)
                    self.projectViewModel?.todoList.onNext(self.workMemoryManager.todoList)
                case Content.moveDoingTitle:
                    self.change(work, category: .doing)
                    self.projectViewModel?.doingList.onNext(self.workMemoryManager.doingList)
                case Content.moveDoneTitle:
                    self.change(work, category: .done)
                    self.projectViewModel?.doneList.onNext(self.workMemoryManager.doneList)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func change(_ data: Work, category: Work.Category) {
        workMemoryManager.update(
            data,
            title: data.title,
            body: data.body,
            date: data.dueDate,
            category: category
        )
        
        switch data.category {
        case .todo:
            list.onNext(workMemoryManager.todoList)
        case .doing:
            list.onNext(workMemoryManager.doingList)
        case .done:
            list.onNext(workMemoryManager.doneList)
        }
    }
    
}
