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
    private var projectViewModel: ProjectViewModel?
    private let disposeBag = DisposeBag()
    
    func setup(
        titleText: String,
        count: Observable<Int>,
        list: BehaviorSubject<[Work]>,
        projectViewModel: ProjectViewModel
    ) {
        self.titleText = titleText
        self.count = count
        self.list = list
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
        let originCategoryTag = data.categoryTag
        let id = data.id
        
        WorkCoreDataManager.shared.delete(data)
        WorkFireBaseManager.shared.deletedData(id: id ?? UUID())
        
        switch originCategoryTag {
        case Work.Category.todo.tag:
            list.onNext(WorkCoreDataManager.shared.todoList)
        case Work.Category.doing.tag:
            list.onNext(WorkCoreDataManager.shared.doingList)
        case Work.Category.done.tag:
            list.onNext(WorkCoreDataManager.shared.doneList)
        default:
            break
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
                    self.change(work, categoryTag: Work.Category.todo.tag)
                    self.projectViewModel?.todoList.onNext(WorkCoreDataManager.shared.todoList)
                case Content.moveDoingTitle:
                    self.change(work, categoryTag: Work.Category.doing.tag)
                    self.projectViewModel?.doingList.onNext(WorkCoreDataManager.shared.doingList)
                case Content.moveDoneTitle:
                    self.change(work, categoryTag: Work.Category.done.tag)
                    self.projectViewModel?.doneList.onNext(WorkCoreDataManager.shared.doneList)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func change(_ data: Work, categoryTag: Int16) {
        let originalCategoryTag = data.categoryTag
        
        WorkCoreDataManager.shared.update(
            data,
            title: data.title,
            body: data.body,
            date: data.dueDate,
            category: categoryTag
        )
        WorkFireBaseManager.shared.updateData(
            id: data.id ?? UUID(),
            title: data.title,
            body: data.body,
            date: data.dueDate,
            category: categoryTag)
        
        switch originalCategoryTag {
        case Work.Category.todo.tag:
            list.onNext(WorkCoreDataManager.shared.todoList)
        case Work.Category.doing.tag:
            list.onNext(WorkCoreDataManager.shared.doingList)
        case Work.Category.done.tag:
            list.onNext(WorkCoreDataManager.shared.doneList)
        default:
            break
        }
    }
    
}
