import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    enum DetailViewMode {
        case add
        case read
        case edit
    }
    
    private(set) var project: Project
    private let useCase: ProjectListUseCase
    private let coordinator: DetailCoordinator
    private var mode: DetailViewMode
    private let disposeBag = DisposeBag()
    
    init(useCase: ProjectListUseCase, coordinator: DetailCoordinator, project: Project, mode: DetailViewMode) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.project = project
        self.mode = mode
    }
    
    struct Input {
        let didTapRightBarButton: Observable<Void>
        let didTapLeftBarButton: Observable<Void>
        let didChangeTitleText: Observable<String?>
        let didChangeDatePicker: Observable<Date>
        let didChangeDescription: Observable<String?>
    }
    
    struct Output {
        let projectTitle: Observable<String>
        let projectDate: Observable<Date>
        let projectDescription: Observable<String>
        let isEditable: Observable<Bool>
        let leftBarButtonText: Observable<String>
        let navigationTitle: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let isEditable = BehaviorRelay<Bool>(value: mode == .add ? true : false)
        let currentTitle = BehaviorRelay<String>(value: "")
        let currentDate = BehaviorRelay<Date>(value: Date())
        let currentDescription = BehaviorRelay<String>(value: "")
        
        input.didChangeTitleText
            .subscribe(onNext: { title in
                currentTitle.accept(title ?? "")
            }).disposed(by: disposeBag)
        
        input.didChangeDatePicker
            .subscribe(onNext: { date in
                currentDate.accept(date)
            }).disposed(by: disposeBag)
        
        input.didChangeDescription
            .subscribe(onNext: { description in
                currentDescription.accept(description ?? "")
            }).disposed(by: disposeBag)
        
        input.didTapRightBarButton
            .subscribe(onNext: { _ in
                if isEditable.value {
                    let newProject = Project(
                        id: self.project.id,
                        title: currentTitle.value,
                        description: currentDescription.value,
                        date: currentDate.value,
                        status: self.project.status
                    )
                    if self.mode == .edit {
                        self.useCase.update(newProject).subscribe(onSuccess: { project in
                            self.project = project
                        }, onFailure: { error in
                            print(error.localizedDescription)
                        }).disposed(by: self.disposeBag)
                    } else {
                        self.useCase.create(newProject).subscribe(onSuccess: { project in
                            self.project = project
                        }, onFailure: { error in
                            print(error.localizedDescription)
                        }).disposed(by: self.disposeBag)
                    }
                    
                }
                self.coordinator.dismiss()
            }).disposed(by: disposeBag)
        
        input.didTapLeftBarButton
            .subscribe(onNext: { _ in
                switch self.mode {
                case .read:
                    self.mode = .edit
                    isEditable.accept(true)
                case .add:
                    self.coordinator.dismiss()
                case .edit:
                    self.mode = .read
                    isEditable.accept(false)
                }
            }).disposed(by: disposeBag)
        
        let output = Output(
            projectTitle: Observable.just(project.title),
            projectDate: Observable.just(project.date),
            projectDescription: Observable.just(project.description),
            isEditable: isEditable.asObservable(),
            leftBarButtonText: mode == .add ? Observable.just("Cancel") : Observable.just("Edit"),
            navigationTitle: Observable.just(project.status.rawValue)
        )
        
        return output
    }
}
