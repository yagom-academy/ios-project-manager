import Foundation
import RxSwift
import RxRelay

final class DetailViewModel {
    enum ViewMode {
        case add
        case read
        case edit
    }
    
    private var mode: ViewMode
    private var project: Project
    private let coordinator: DetailCoordinator
    private let useCase: ProjectListUseCase
    
    init(useCase: ProjectListUseCase, coordinator: DetailCoordinator, project: Project, mode: ViewMode) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.project = project
        self.mode = mode
    }
    
    func dismiss() {
        coordinator.dismiss()
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
        let projectDescription: Observable<String?>
        let isEditable: Observable<Bool>
        let leftBarButtonText: Observable<String>
        let navigationTitle: Observable<String>
        let isDescriptionTextValid: Observable<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let isEditable = BehaviorRelay<Bool>(value: mode == .add ? true : false)
        let currentTitle = BehaviorRelay<String?>(value: nil)
        let currentDate = BehaviorRelay<Date?>(value: nil)
        let currentDescription = BehaviorRelay<String?>(value: nil)
        let isDescriptionTextValid = BehaviorRelay<Bool>(value: false)
        
        input.didChangeTitleText
            .subscribe(onNext: { currentTitle.accept($0) }).disposed(by: disposeBag)
        
        input.didChangeDatePicker
            .subscribe(onNext: { currentDate.accept($0) }).disposed(by: disposeBag)
        
        input.didChangeDescription
            .subscribe(onNext: {
                currentDescription.accept($0)
                if $0?.count ?? .zero > 1000 || $0 == "" || $0 == Placeholder.body {
                    isDescriptionTextValid.accept(false)
                } else {
                    isDescriptionTextValid.accept(true)
                }
                
            }).disposed(by: disposeBag)
        
        input.didTapRightBarButton
            .withUnretained(self).subscribe(onNext: { owner, _ in
                if isEditable.value {
                    let newProject = Project(
                        id: owner.project.id,
                        title: currentTitle.value ?? owner.project.title,
                        description: currentDescription.value ?? owner.project.description,
                        date: currentDate.value ?? owner.project.date,
                        status: owner.project.status
                    )
                    let single = owner.mode == .edit ? owner.useCase.update(newProject) : owner.useCase.create(newProject)
                    single.subscribe(
                        onSuccess: { owner.project = $0 },
                        onFailure: { print($0.localizedDescription) }
                    ).disposed(by: disposeBag)
                }
                owner.coordinator.dismiss()
            }).disposed(by: disposeBag)
        
        input.didTapLeftBarButton
            .withUnretained(self).subscribe(onNext: { owner, _ in
                switch owner.mode {
                case .read:
                    owner.mode = .edit
                    isEditable.accept(true)
                case .add:
                    owner.coordinator.dismiss()
                case .edit:
                    owner.mode = .read
                    isEditable.accept(false)
                }
            }).disposed(by: disposeBag)
        
        let output = Output(
            projectTitle: Observable.just(project.title),
            projectDate: Observable.just(project.date),
            projectDescription: Observable.just(project.description == "" ? Placeholder.body : project.description),
            isEditable: isEditable.asObservable(),
            leftBarButtonText: mode == .add ? Observable.just("Cancel") : Observable.just("Edit"),
            navigationTitle: Observable.just(project.status.rawValue),
            isDescriptionTextValid: isDescriptionTextValid.asObservable()
        )
        
        return output
    }
}
