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
        let didChangeTitleText: Observable<String>
        let didChangeDatePicker: Observable<Date>
        let didChangeDescription: Observable<String>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
