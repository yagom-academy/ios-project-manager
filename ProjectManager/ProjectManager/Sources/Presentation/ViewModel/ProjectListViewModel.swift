import Foundation
import RxSwift
import RxCocoa

final class ProjectListViewModel {
    private var allProjects: [Project] = []
    private var projectList: [[Project]] = [[], [], []]
    private let useCase: ProjectListUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: ProjectListUseCase = DefaultProjectListUseCase()) {
        self.useCase = useCase
    }
    
    struct Input {
        let didTapProjectCell: Observable<Int>
        let didTapAddButton: Observable<Void>
        let didTapPopoverButton: Observable<(Project, ProjectState)>
        let didSwapeToTapDeleteButton: Observable<Project>
    }
    
    struct Output {
        let projectList = [
            BehaviorRelay<[Project]>(value: []),
            BehaviorRelay<[Project]>(value: []),
            BehaviorRelay<[Project]>(value: [])
        ]
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        useCase.fetch().subscribe(onNext: { newProjects in
            self.allProjects = newProjects.sorted { $0.date < $1.date }
            ProjectState.allCases.forEach { state in
                let filteredData = self.allProjects.filter { $0.status == state }
                self.projectList[state.index] = filteredData
                output.projectList[state.index].accept(filteredData)
            }
        }).disposed(by: disposeBag)
        
        input.didTapProjectCell
            .subscribe(onNext: { _ in
                print("프로젝트 상세화면으로 이동")
            }).disposed(by: disposeBag)
        
        input.didTapAddButton
            .subscribe(onNext: { _ in
                print("프로젝트 등록화면으로 이동")
            }).disposed(by: disposeBag)
        
        input.didTapPopoverButton
            .subscribe(onNext: { _ in
                print("프로젝트를 유저가 선택한 state로 업데이트")
            })
            .disposed(by: disposeBag)
        
        input.didSwapeToTapDeleteButton
            .subscribe(onNext: { project in
                self.useCase.delete(project)
            })
            .disposed(by: disposeBag)

        return output
    }
}
