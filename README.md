# 📲 프로젝트 관리 앱

<br>

## 💾 프로젝트 소개
>**프로젝트 기간** : 2022-09-04 ~ 2022-09-15 <br>
**소개** : 할 일을 TODO, DOING, DONE으로 구분하여 관리할 수 있는 아이패드의 프로젝트 관리 앱 <br>
**리뷰어** : [**찰리**](https://github.com/kcharliek)

 | [예톤](https://github.com/yeeton37) |
|:---:|
|<img src = "https://i.imgur.com/r0SSf3L.jpg" width=200 height = 210>|



## 목차

- [STEP 1](#-STEP-1)
    - [프로젝트 적용 기술](#-프로젝트-적용-기술)
- [STEP 2](#-STEP-2)
    - [폴더 구조](#-폴더-구조)
    - [프로젝트 코드 설명](#-프로젝트-코드-설명)
    - [고민한 점](#-고민한-점)


<br/>

# 😃 STEP 1

## ❗️ 프로젝트 적용 기술 

### 1. 최종 선택 기술
|분류|적용 기술|
|:--|:--|
|의존성 관리도구|Swift Package Manager|
|UI|UIKit|
|로컬 DB|Core data|
|원격 DB|Firebase Realtime database|
|아키텍쳐|Clean Architecture + MVVM|

#### 1️⃣ 로컬 / 원격 DB
> 로컬 DB는 `Core data`, 원격 DB는 `Firebase Realtime database`로 결정하였습니다.

#### 2️⃣ Clean Architecture + MVVM 
> RxSwift를 사용하지 않고 Clean Architecture에 MVVM을 적용하여 구현해본 뒤, 추후 RX로 전환해보는 것을 목표로 잡았습니다. 


### 2. 고민한 점들

#### 1️⃣ 하위 버전 호환성에는 문제가 없는가?
Core data는 iOS 3.0, iPadOS 3.0, Firebase는 iOS 10.0부터 지원하고 있고, 현재 프로젝트 타겟은 14.1이기에 하위 버전 호환성 문제가 없다고 판단했습니다.

#### 2️⃣ 안정적으로 운용 가능한가?
>CoreData 

애플에서 지원하는 프레임워크이기 때문에 애플이 사라지지 않는 한 안정적으로 운용 가능할 것이라고 판단하였습니다.

>❗️Firebase

구글에서 제공하는 플랫폼이긴 하지만 third-party이기 때문에 추후 구글이 서비스 제공을 중단할 수도 있기에 잘 모르겠습니다.

#### 3️⃣ 미래 지속가능성이 있는가?
>CoreData

위와 동일한 이유입니다.

>Firebase 

위와 동일한 이유입니다.

#### 4️⃣ 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
>Core Data

코어데이터는 스레드 안정성을 보장하지 않는다는 리스크가 있습니다. [문서](https://duncsand.medium.com/threading-43a9081284e5)를 참고하여 모든 백그라운드 Core Data를 처리하는 단 하나의 컨텍스트만을 생성하면 이 문제를 해결할 수 있을 것으로 예상됩니다. 

>Firebase 

데이터가 작을 때는 문제가 되지 않지만, 데이터가 크고 구조가 잘못된 경우 읽기 및 쓰기를 기준으로 요금을 청구하기 때문에 비용 문제가 발생한다는 리스크가 있습니다. 하지만 이번 프로젝트에서는 데이터의 크기가 작기 때문에 비용 문제가 발생하지 않을 것으로 예상됩니다.

#### 5️⃣ 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
대표적인 의존성 관리도구로는 코코아팟(Cocoapods), 카르타고(Carthage), 스위프트 패키지 매니저(Swift Package Manager)가 있습니다.

First-party 라이브러리인 `스위프트 패키지 매니저(Swift Package Manager)`를 사용할 예정입니다.

>Core Data 

애플의 프레임워크이므로 의존성 관리 도구를 사용할 필요가 없습니다.

>Firebase 

Swift Package Manager를 지원합니다.

#### 6️⃣ 이 앱의 요구기능에 적절한 선택인가?
[FireBase 문서](https://firebase.google.com/docs/firestore/rtdb-vs-firestore)에서 `RealTime DB`와 `Cloud Firestore`을 선택하는 기준이 있어서 확인해보았습니다.

만약 큰 단위의 데이터에 대한 요청이 종종 발생하는 앱을 개발한다면(예를 들어 뉴스앱, 데이팅앱) `Firebase Firestore`가 더 유리하며, 반대로 read/write가 자주 발생하는 앱이라면 `Firebase Realtime database`가 더 유리하다는 문서를 보고 이번 프로젝트의 특성상 `Firebase Realtime database`이 더 적합하다고 판단하여 결정하였습니다.

# 😃 STEP 2

## 📚 폴더 구조
```
.
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Data
│   └── Repositories
│       └── Repositories
│           ├── LocalTaskRepository.swift
│           └── Protocol
│               └── TaskRepositoryProtocol.swift
├── Domain
│   ├── Entities
│   │   ├── Enum
│   │   │   └── TaskState.swift
│   │   ├── Task.swift
│   │   └── TaskModelDTO.swift
│   ├── Extensions
│   │   ├── Extension+Date.swift
│   │   └── Extension+String.swift
│   ├── UseCases
│   │   ├── Protocol
│   │   │   └── TaskUseCaseProtocol.swift
│   │   └── TaskUseCase.swift
│   └── ViewModel
│       └── TaskViewModel.swift
├── Fonts
│   └── EF_Diary.ttf
├── Info.plist
├── Presentation
│   ├── TaskService
│   │   ├── MainTaskService.swift
│   │   └── Protocol
│   │       └── TaskServiceProtocol.swift
│   └── View
│       ├── Cells
│       │   └── TaskListCell.swift
│       ├── CreateTaskViewController.swift
│       ├── EditTaskViewController.swift
│       ├── MainTaskViewController.swift
│       ├── TaskHeaderView.swift
│       └── TaskTableView.swift
└── Resources
    ├── Assets.xcassets
    │   ├── AccentColor.colorset
    │   │   └── Contents.json
    │   ├── AppIcon.appiconset
    │   │   └── Contents.json
    │   └── Contents.json
    └── Base.lproj
        └── LaunchScreen.storyboard
```

## 📲 프로젝트 코드 설명

- ### Domain
    - #### Entity
        - 네트워킹을 통해 혹은 local DB/ remote DB를 통해 받아오는 데이터
    - #### Use cases
        - Entity -> Model 타입으로 변경 후 반환
- ### Presentation
    - #### Service
        - 다른 곳에서는 ViewModel이라고 칭하는 곳도 많은데, 뷰컨트롤러에 대한 로직이 담겨있는 곳이므로 Service라고 네이밍했습니다.
        - ViewModel -> Model, Model -> ViewModel로 변경
    - #### ViewController
        - viewModel 가져와 사용
- ### Data
    - #### Repository
        - Entity를 클로저로 반환
- ### 기타
    - #### Model
    - #### ViewModel
        - model을 뷰에 보이는 형식으로 바꿈(ex. Date -> String)


## 🤔 고민한 점

### 1️⃣ MVVM 패턴의 구조

MVVM 구조로 구현할 때, View와 Service 사이에서 데이터 변화를 관측하고, 스스로 UI를 변경할 수 있도록 하기 위한 방법에 대해 생각해보았다.

`Closure`를 이용한 방법으로 바인딩을 하고자했다. `Closure`를 이용한 방식은 Service내에 closure를 정의하고, 호출이 필요한 곳에 위치시켜둔 후 ViewController에서 해당 클로저를 구현하여 작동하는 방식이다. 

하지만 클로저에 대한 이해가 부족하여  delegate를 통해 전달해주는 방식을 이용했다. 그래서 MVVM 패턴을 제대로 적용하지 못한 것 같다는 생각이 든다.

    ➡️ 추후 5️⃣번에서 해결!

<br/>

2️⃣  화면마다 하나의 Service 생성

각 뷰컨트롤러마다 `Service` 타입을 만들어주어 사용하고 싶었으나 메인 뷰컨트롤러가 아닌 다른 뷰컨트롤러에서는 크게 데이터 전달이 필요한 로직이 많이 요구되지 않아 하나의 `Service`만 생성해주었음.

    ➡️ 맞는 방향인 것인가?

<br/>

3️⃣ 뷰모델 내부의 input과 output 구현

Service 내부에 `Input`과 `Output` 타입을 구현해주었다.

`Input`은 ViewController에서 Service로 이벤트가 발생했음을 알리고, `Output`은 데이터를 화면에 보이는 타입으로 변경하여 Service에서 ViewController로  뷰모델 타입의 데이터를 전달해주는 역할을 한다고 이해했다.

따라서 ViewController에서 어떤 이벤트가 발생했을 때마다 클로저를 통해 Service의 input에 구현된 클로저를 호출해주었다.


<br/>

4️⃣ Repository 및 Usecase 추상화

추후에 프로젝트 매니저2를 진행할 때 `Remote`의 `Repository`도 구현하게 될텐데, 이를` RepositoryProtocol` 타입을 채택하여 구현하면 나중에 갈아끼우기만 해도 코드가 작동할 수 있도록 추상화해주었다. 

- [TaskUseCase를 TaskUseCaseProtocol를 통해 추상화 한 예]
```swift
struct TaskUseCase: TaskUseCaseProtocol {
    var repository: TaskRepositoryProtocol
    
    init(repository: TaskRepositoryProtocol) {
        self.repository = repository
    }
}
```

```swift
protocol TaskUseCaseProtocol {
    func insertContent(task: Task)
    func fetch() -> [Task]
    func update(task: Task)
    func delete(task: Task)
}
```


```swift
class MainTaskService: TaskServiceProtocol {
    let taskUseCase: TaskUseCaseProtocol = TaskUseCase(repository: LocalTaskRepository())
}
```

<br/>

5️⃣ 데이터의 전달 방식 고민

- 메인 뷰컨트롤러 -> 수정 뷰컨트롤러 or 생성 뷰컨트롤러: 의존성 주입을 통해 데이터를 바로 전달
- 수정 뷰컨트롤러 or 생성 뷰컨트롤러 -> 메인 뷰컨트롤러: `delegate` 패턴을 통해 데이터를 전달하여 의존 관계를 역전

    ➡️ 리뷰어 찰리의 조언을 받아 리팩토링함






