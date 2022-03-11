import Foundation
import RxSwift
import RxCocoa
import UIKit

final class ProjectListViewModel {
    private var allProjects: [Project] = []
    private(set) var projectList: [[Project]] = [[], [], []]
    private let useCase: ProjectListUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: ProjectListUseCase = DefaultProjectListUseCase()) {
        self.useCase = useCase
    }
    
    struct Input {
        let didTapProjectCell: [Observable<Int>]
        let didTapAddButton: Observable<Void>
        let didTapPopoverButton: [Observable<Project?>]
        let didSwapeToTapDeleteButton: [Observable<Project>]
    }
    
    struct Output {
        let projectList: [Observable<[Project]>]
    }
    
    func transform(input: Input) -> Output {
        let projectList = [
                BehaviorSubject<[Project]>(value: []),
                BehaviorSubject<[Project]>(value: []),
                BehaviorSubject<[Project]>(value: [])
        ]
        
        useCase.fetch().subscribe(onNext: { newProjects in
            self.allProjects = newProjects.sorted { $0.date < $1.date }
            ProjectState.allCases.forEach { state in
                let filteredData = self.allProjects.filter { $0.status == state }
                self.projectList[state.index] = filteredData
                projectList[state.index].onNext(filteredData)
            }
        }).disposed(by: disposeBag)
        
        input.didTapProjectCell
            .forEach({ observable in
                observable
                    .subscribe(onNext: { index in
                        print("프로젝트 상세화면으로 이동")
//                        self.useCase.update(<#T##item: Project?##Project?#>)
                    }).disposed(by: disposeBag)
            })
        
        input.didTapAddButton
            .subscribe(onNext: { _ in
                self.useCase.create(Project(title: "프로젝트 제목", description: ["내용", "내용\n내용\n내용\n내용", "내용\n내용"].randomElement()!, date: Date()))
            }).disposed(by: disposeBag)
        
        input.didTapPopoverButton.forEach {
            $0.subscribe(onNext: { data in
                data.flatMap{ project in
                    print("팝오버를 띄우거라")
                }
            }).disposed(by: self.disposeBag)
        }
        
        input.didSwapeToTapDeleteButton
            .forEach({ observable in
                observable
                    .subscribe(onNext: { project in
                        self.useCase.delete(project)
                    })
                    .disposed(by: disposeBag)
            })

        return Output(projectList: projectList.map { $0.asObservable() })
    }
}
