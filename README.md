# 프로젝트 매니저

## 📖 목차

1. [📢 소개](#1.)
2. [👤 팀원](#2.)
3. [⏱️ 타임라인](#3.)
4. [📊 UML & 파일트리](#4.)
5. [📱 실행 화면](#5.)
6. [🧨 트러블 슈팅](#6.)
7. [🔗 참고 링크](#7.)

<br>

<a id="1."></a>

## 1. 📢 소개
프로젝트를 생성하고 관리하고 날짜에 맞게 진행하세요!
기한이 지난 프로젝트는 표시됩니다!

> **핵심 개념 및 경험**
> 
> - **MVVM**
>   - `MVVM`으로 아키텍쳐 설계
> - **CleanArchitecture**
>   - `CleanArchitecture` 개념을 이용한 객체 분리
> - **Combine**
>   - `Combine`을 이용한 데이터 바인딩
> - **PopoverPresentationController**
>   - `iPad`에서 `ActionSheet` 사용을 위한 `PopoverPresentationController` 활용

<br>

<a id="2."></a>

## 2. 👤 팀원

| [Erick](https://github.com/h-suo) |
| :--------: | 
| <Img src = "https://user-images.githubusercontent.com/109963294/235300758-fe15d3c5-e312-41dd-a9dd-d61e0ab354cf.png" width="350"/>|

<br>

<a id="3."></a>
## 3. ⏱️ 타임라인

> 프로젝트 기간 :  2023.09.18 ~ 2023.10.06

|날짜|내용|
|:---:|---|
| **2023.09.18** |▫️ 기술 스택 선정 <br>|
| **2023.09.20** |▫️ `Project` 엔티티 생성 <br> ▫️ `MainView`, `ProjectListView` UI 구현 <br>|
| **2023.09.22** |▫️ `ProjectDetailView` UI 구현 <br>|
| **2023.09.23 ~<br>2023.09.28** |▫️ `Utils` 구현 <br> ▫️ `ProjectUseCase` 구현 <br>▫️ 각 `View`의 `ViewModel` 구현 <br> ▫️ `ProjectManagerCoordinator` 구현 <br>|
| **2023.09.29** |▫️ README 작성 <br>|

<br>

<a id="4."></a>
## 4. 📊 UML & 파일트리

### UML

<Img src = "https://github.com/h-suo/ios-project-manager/assets/109963294/3a869cbb-c67c-430e-b2a9-18bd49b59cf9" width="1000"/>

<br>

### 파일트리
```
ProjectManager
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Domain
│   ├── Entity
│   │   └── Project.swift
│   └── UseCase
│       └── ProjectUseCase.swift
├── Presentation
│   ├── Flow
│   │   └── ProjectManagerCoordinator.swift
│   ├── Main
│   │   ├── View
│   │   │   └── MainViewController.swift
│   │   └── ViewModel
│   │       └── MainViewModel.swift
│   └── ProjectList
│   │   ├── View
│   │   │   ├── Component
│   │   │   │   ├── CircleCountLabel.swift
│   │   │   │   └── HeaderView.swift
│   │   │   ├── ProjectListViewController.swift
│   │   │   └── ProjectTableViewCell.swift
│   │   └── ViewModel
│   │       ├── ProjectListViewModel.swift
│   │       └── ProjectTableViewCellViewModel.swift
│   └── ProjectDetail
│       ├── View
│       │   ├── AddProjectViewController.swift
│       │   ├── EditProjectViewController.swift
│       │   └── ProjectDetailViewController.swift
│       └── ViewModel
│           └── ProjectDetailViewModel.swift
├── Utils
│   ├── Extensions
│   │   └── Calendar+.swift
│   └── Managers
│       └── CurrentDateFormatManager.swift
└── Resources
```

<br>

<a id="5."></a>
## 5. 📱 실행 화면
| 프로젝트 생성 |
| :--------------: |
| <Img src = "https://github.com/h-suo/ios-project-manager/assets/109963294/208a6634-095e-461b-b052-92671bc12d24" width="800"/> |
| **프로젝트 수정** |
| <Img src = "https://github.com/h-suo/ios-project-manager/assets/109963294/4533fec6-4278-441e-8371-0b765052a8f1" width="800"/>  |
| **프로젝트 이동** |
| <Img src = "https://github.com/h-suo/ios-project-manager/assets/109963294/70f79a7b-dfa8-43ef-bbe6-c89a83f284f4" width="800"/> |
| **프로젝트 삭제** |
| <Img src = "https://github.com/h-suo/ios-project-manager/assets/109963294/6dded2b8-cff4-442e-9e58-51a4ae6c445d" width="800"/> |

<br>

<a id="6."></a>
## 6. 🧨 트러블 슈팅

### 1️⃣ CleanArchitecture & MVVM

#### 🔥 문제점
`MVVM` 패턴으로만 프로젝트를 설계하기엔 좀 더 체계적인 설계 방법이 필요했습니다.

#### 🧯 해결방법
`CleanArchitecture`와 `MVVM`을 함께 적용하여 프로젝트를 구현했습니다.

**객체 분리**
- Application : `AppDelegate`와 `SceneDelegate` 등 앱의 전체적인 동작을 관여하는 파일 그룹입니다.
- Domain
  - Entity : 앱에서 사용하는 데이터 모델입니다.
  - UseCase : 앱의 큰 동작 즉 비즈니스 로직을 담당합니다.
- Presentation
  - Flow : `Coordinator`가 있으며 `View`의 흐름을 제어을 제어합니다.
  - View : `UI` 구현 및 사용자 이벤트 수신을 담당합니다.
  - ViewModel : `View`에 수신된 이벤트 관리 및 사용자에게 보여줄 데이터 관리를 합니다.
- Utils : 앱에서 사용하기 위한 확장 기능의 그룹입니다.
  - Extensions
  - Managers

<br>

### 2️⃣ Protocol

#### 🔥 문제점
객체가 추상화된 타입이 아닌 실제 객체에 의존할 경우 객체 사이 의존성이 높아지고 `DIP`를 위배하는 문제가 있었습니다.

#### 🧯 해결방법
`View`나 `ViewModel`에 `init`으로 객체를 주입할 때 실제 객체가 아닌 `Protocol`을 주입 받아 추상화된 타입에 의존하도록 했습니다.
객체가 실제 객체가 아닌 추상화된 타입에 의존할 경우, 객체간 의존성을 분리할 수 있으며 추후 다른 객체 교체하기 쉽고 `DIP`를 적용할 수 있다는 점에서 `Protocol`을 활용했습니다.

또한 객체가 채택한 `Protocol`을 보고 어떤 역할을 하는 객체인지 유추할 수도 있기 때문에 가독성면에서도 장점이 있다고 생각했습니다.

**ViewModel**
```swift
protocol ProjectListViewModelInput {
    // ...
}

protocol ProjectListViewModelOutput {
    // ...
}

typealias ProjectListViewModel = ProjectListViewModelInput & ProjectListViewModelOutput

final class DefaultProjectListViewModel: ProjectListViewModel {
    // MARK: - OUTPUT
    // ...
}

// MARK: - INPUT View event methods
extension DefaultProjectListViewModel {
    // ...
}
```

**ViewController**
```swift
final class ProjectListViewController: UIViewController {
    
    private let viewModel: ProjectListViewModel
    // ...

    init(viewModel: ProjectListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // ...
}
```

<br>

### 3️⃣ 데이터 바인딩

#### 🔥 문제점
`View`와 `ViewModel` 사이의 데이터 바인딩을 어떤 방식으로 할지 고민했습니다.

#### 🧯 해결방법
`Closure`, `Observable` 등을 이용한 방법이 있었지만 `Combine`을 이용한 데이터 바인딩을 했습니다.

**ViewModel**
```swift
protocol ProjectListViewModelOutput {
    var projectsPublisher: Published<[Project]>.Publisher { get }
    // ...
}

typealias ProjectListViewModel = ProjectListViewModelInput & ProjectListViewModelOutput

final class DefaultProjectListViewModel: ProjectListViewModel {
    
    @Published private var projects: [Project] = []
    
    // ...
    
    // MARK: - OUTPUT
    var projectsPublisher: Published<[Project]>.Publisher { $projects }
    // ...
}
```
- `Protocol` 내에 `property wrapper`의 정의를 지원하지 않기 때문에 래핑 타입인 `Published<[Project]>.Publisher`을 프로퍼티로 가지고 있도록 했습니다.

**ViewController**
```swift
final class ProjectListViewController: UIViewController {
    
    private var cancellables: [AnyCancellable] = []
    // ...
    
    // MARK: - Data Binding
    func setupBindings() {
        viewModel.projectsPublisher.sink { [weak self] projects in
            guard let self else {
                return
            }
            
            var snapShot = NSDiffableDataSourceSnapshot<Section, Project>()
            snapShot.appendSections([.main])
            snapShot.appendItems(projects)
            dataSource.apply(snapShot)
        }.store(in: &cancellables)
        
        // ...
    }
}
```
- `sink`를 이용해 간단히 구독하여 값을 받아오도록 했습니다.

<br>

### 4️⃣ ActionSheet

#### 🔥 문제점
`iPad`에서는 `iPhone`과 달리 일반 `ActionSheet`을 사용할 수 없었습니다.

```swift
let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

// ...
presenter.present(alert, animated: true)
```
- `ActionSheet`이 `UIModalPresentationPopover`이니 위치를 설정하라는 에러가 발생했습니다.

#### 🧯 해결방법
`popoverPresentationController`의 속성을 설정하여 `UIModalPresentationPopover`가 자신이 어디 나타날지 알 수 있게 했습니다.

```swift
let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
alert.modalPresentationStyle = .popover
alert.popoverPresentationController?.permittedArrowDirections = [.up, .down]
alert.popoverPresentationController?.sourceView = target
alert.popoverPresentationController?.sourceRect = CGRect(
    x: location.x,
    y: location.y,
    width: 0,
    height: 0
)

// ...
presenter.present(alert, animated: true)
```
- `permittedArrowDirections` 을 `up`, `down` 모두 설정하여 화살표가 위아래 모두 위치할 수 있도록 설정했습니다.
- `sourceView`를 `tableView`로 설정하여 팝오버 컨트롤러가 타겟할 `View`를 설정했습니다.
- `sourceRect`를 선택된 `location`로 설정하여 제스쳐를 취한 곳에 팝오버 컨트롤러가 나오도록 했습니다.

<br>

<a id="7."></a>
## 7. 🔗 참고 링크
- [🍎 Apple: UIModalPresentationStyle](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle)
- [🍎 Apple: UIPopoverPresentationController](https://developer.apple.com/documentation/uikit/uipopoverpresentationcontroller)
- [🍎 Apple: sink(receiveValue:)](https://developer.apple.com/documentation/combine/fail/sink(receivevalue:))
- [😺 GitHub: iOS-Clean-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)
- [📔 Vlog: How to Define a Protocol With @Published Property Wrapper Type](https://swiftsenpai.com/swift/define-protocol-with-published-property-wrapper/)
