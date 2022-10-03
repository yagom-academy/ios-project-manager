# 프로젝트 관리 앱

## 프로젝트 소개
각각의 프로젝트를 관리하는 앱을 생성한다.

> 프로젝트 기간: 2022-09-05 ~ 2022-09-30</br>
> 팀원: [수꿍](https://github.com/Jeon-Minsu), [Hugh](https://github.com/Hugh-github) </br>
리뷰어: [Ryan](https://github.com/ryan-son)</br>


## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [💡 키워드](#-키워드)
- [⏱ TimeLine](#-TimeLine)
- [🛠 기술 스택](#-기술-스택)
- [📂 폴더 구조](#-폴더-구조)
- [📱 화면 구현](#-화면-구현)
- [📃 기능 설명](#-기능-설명)
- [🚀 TroubleShooting](#-TroubleShooting)
- [📚 참고문서](#-참고문서)

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|수꿍|휴|
|:---:|:---:|
|<image src = "https://i.imgur.com/6HkYdmp.png" width="250" height="250">|<image src = "https://i.imgur.com/5oaoHWd.png" width="250" height="250">|
|[수꿍](https://github.com/Jeon-Minsu)|[휴](https://github.com/Hugh-github)|

## ⏱ TimeLine

### Week 3
> 2022.09.19 ~ 2022.09.23

- 2022.09.19 ~ 2022.09.23
    - STEP 2 2차 리팩토링
        - View 및 ViewModel 통합 및 분리
        - LocalDatabaseManager 로직 통합
        - DateFormatterManager 구현
        - POP 방식을 이용한 ViewModel 수정
        - Spy Test 적용

### Week 4
> 2022.09.26 ~ 2022.09.30

- 2022.09.26
    - View 변경 이력을 처리하는 History 기능 구현

- 2022.09.27
    - History 기능을 ProjectManagerController로 이동
    - HistoryPopoverController 및 HistoryListCell 구현
    
- 2022.09.28
    - NetworkObserver 타입 구현 및 적용
    - Firebase를 통한 RemoteDatabaseManager 구현
    - JSONManager 타입 구현 및 적용
    
- 2022.09.29
    - CoreData와 Firebase 동기화 메서드 구현
    - STEP3 PR
    

    
## 💡 키워드

- `UITableView`, `HeaderView`, `UIGraphicsImageRenderer`, `DatePicker`, `Core Data`, `SPM`, `firebase`, `MVVM`, `Test Double`, `PopoverController`
    
## 기술 스택
### target version
`iOS 14.0`, `iPadOS 14.0`

- iOS 14.0 이상을 사용하는 유저가 전체 유저의 99%를 차지하고 이번 프로젝트에서 async, await 및 sendAction을 통한 button 이벤트 테스트를 하기 위해 target version을 14.0으로 결정했습니다. 

|iOS|iPadOS|
|:---:|:---:|
|<image src = "https://i.imgur.com/MuDZgV0.png" width="200" height="300">|<image src = "https://i.imgur.com/SxroxGG.png" width="200" height="300">|

(출처: https://developer.apple.com/support/app-store/)

### UI
- UIKit
이번 프로젝트에서 MVVM과 테스트 코드에 비중을 두고 진행할 계획이기 때문에 UIKit만을 사용하여 데이터 바인딩을 직접 구현해보는 것이 라이브러리를 사용하기 전에 중요한 경험이 될 것이라고 생각했습니다.

### Architecture
- MVVM
MVC 아키텍처보다는 View를 다루는 로직에 대하여 테스트하기 용이하기 때문에 MVVM 아키텍처를 선택하였습니다.
기회가 된다면 clean architecture 와 coordinator를 적용해 볼 계획입니다.

### 동시성
- Swift Concurrency
이번 프로젝트에서는 rx보다 swift 5.5 이후에 등장한 async await을 이용해 프로젝트를 진행하기로 결정했습니다.
    
### database
- Local : CoreData
    Apple에서 제공하는 first party 기술을 먼저 익히고자 Core Data를 선택했습니다.
    또한, SQLite보다 속도가 빨라 더 만족스러운 UX를 제공할 수 있다고 생각했습니다.
- Remote : Firebase
    Firebase 같은 경우 iOS 10.0 이상부터 사용이 가능합니다.
    NoSQL기반 데이터베이스로 관계형 데이터베이스보다 빠르고 간편합니다.
    또한, 다른 데이터 베이스들과 다르게 RTSP(Real Time Stream Protocol) 방식의 데이터베이스를 지원하고 있기 때문에 소켓 기반 서버를 만들어서 통신하는 것 보다 훨씬 코드 양이 줄게되어 코드 몇 줄로도 원하는 구성을 만들 수 있습니다.

### 의존성 관리도구
- SPM(Swift Package Manager)

## 📂 폴더 구조
```
├── ProjectManager/
│   ├── Model/
│   │   ├── ProjectUnit
│   │   ├── HistoryLog
│   │   ├── JSONManager
│   │   └── JSONError
│   ├── View/
│   │   ├── MainView/
│   │   │   ├── ProjectManagerController
│   │   │   ├── ProjectListViewController
│   │   │   ├── PopoverController
│   │   │   ├── ProjectManagerListCell
│   │   │   ├── SectionHeaderView
│   │   │   ├── HistoryPopoverController
│   │   │   └── HistoryListCell
│   │   ├── AddView/
│   │   │   ├── ProjectAdditionController
│   │   │   └── ProjectAdditionScrollView
│   │   └── EditView/
│   │       └── ProjectModificationController
│   ├── ViewModel/
│   │   ├── ToDoViewModel
│   │   ├── DoingViewModel
│   │   ├── DoneViewModel
│   │   ├── Observable
│   │   └── Protocol/
│   │       ├── CommonViewModelLogic
│   │       ├── ContentAddible
│   │       ├── ContentEditable
│   │       └── StatusChangable
│   └── Resource/
│       ├── AppDelegate
│       ├── SceneDelegate
│       ├── DateFormatter/
│       │   └── DateFormatterManager
│       ├── NameSpace/
│       │   ├── ProjectStatus
│       │   └── Alert
│       ├── CoreData/
│       │   ├── Project+CoreDataClass
│       │   └── Project+CoreDataProperties
│       ├── Database/
│       │   ├── DatabaseError
│       │   ├── LocalDatabaseManager
│       │   ├── RemoteDatabaseManager
│       │   └── CoreDataContainer
│       ├── Extension/
│       │   ├── ReuseableCell
│       │   ├── UITableView+Extension
│       │   ├── Date+Extension
│       │   ├── UIButton+Extension
│       │   ├── OSLog+Extension
│       │   ├── Notification.Name+Extension
│       │   └── UIViewController+Extension
│       └── Network/
│           ├── NetworkObserver
│           └── NetworkError
└── ProjectManagerTests/
    ├── ProjectManagerTests
    ├── ToDoViewModelSpy
    └── DoingViewModelSpy
```
    
## 📱 화면 구현

- TODO, DOING, DONE 화면을 각각 TableView를 이용해 구현
![](https://i.imgur.com/aw3o1ry.png)

- Modal의 formSheet 스타일로 AddView 구현
![](https://i.imgur.com/inAFoRU.png)

- Add 버튼을 통한 프로젝트 추가 구현
![](https://i.imgur.com/Hbqt1ro.gif)

- Popover 표시 및 버튼 클릭으로 인한 프로젝트 이동 구현
![](https://i.imgur.com/yZSXUN4.gif)

- 기존 프로젝트 수정 구현
![](https://i.imgur.com/DQrGl7c.gif)

    
## 📃 기능 설명
    
- MainView
    - ~~3개의 Table View를 하나의 Custom StackView에 저장해 관리~~ (2022.09.17)
    ~~- 3개의 Table View를 각각의 View Controller로 구현~~
        ~~- 각의 Table View에서 사용하는 ViewModel이 다르다고 판단(TODO, DOING, DONE에서 사용하는 데이터 및 기능이 다르다.)~~
    - 하나의 ProjectListViewController를 구현애서 재사용 (인스턴스화할 때 viewModel 주입해 주는 방식으로 수정)
    - Table View의 header로 사용할 Custom View 구현
    - LocalData 와 RemoteData 동기화
    
- AddView
    - Modal Style 중 form sheet 사용
    - Date Picker를 사용해 날짜를 선택하는 View 구현
    - Text Field와 Text View에 shadow 효과 추가
    
- EditView
    - EditView에서 사용하는 기능을 추상화(Editable)
    - TapGesture가 인식되면 EditView로 이동

- PopoverController
    - PopoverController에서 사용하는 기능 추상화(Readjustable)
    - LongPressGesture가 인식되면 popover View로 이동
    
- HistoryPopoverController
    - History를 보여줄 View 구현
    
- ViewModel
    - ToDoViewModel, DoingViewModel, DoneViewModel 구현
    - **공통기능**
        1. swipe delete 이벤트를 처리하는 로직
        2. Table View에서 보내주는 indexPath로 데이터를 가져오는 로직
        3. 데이터의 Section을 이동시키는 로직(Readjustable 채택)
        4. 데이터의 content를 수정하는 로직(Editable 채택)
    -  **차이점**
        1. 각각의 Section(Table View)에서 사용할 데이터
        2. 데이터를 추가하는 로직(ToDoViewModel)

- NetworkObserver
    - 현재 기기가 네트워크가 연결됐는지 확인
    
- LocalDatabaseManager
    - inMemory 방식과 onDisk 방식 구현
    
- RemoteDatabaseManager
    - firebase 메서드 구현
    
## 🚀 TroubleShooting

### STEP 3
#### T1. HistoryPopoverController 데이터 지연 반영
- HistoryPopoverController는 tableView로 구성되어, UI 구성, DataSource, Snapshot 구현 작업을 viewDidLoad가 될 때 처리했었습니다. History 기능은 각각의 뷰모델에서 property observer를 통해 변경이 감지되어 있을때 수행할 수 있도록, configureObserver 메서드를 통해 옵저빙하였고, 이를 ProjectManagerController의 viewDidLoad에서 호출하였습니다. 현재 HistoryPopoverController는 ProjectManagerController에서 프로퍼티로서 초기화하고 있습니다. 
- 그러던 가운데, 프로젝트 추가, 일정 변경, 삭제이 이루어질 때, HistoryPopoverController에 정상적으로 반영되어야 했는데, 좌측 상단의 History Button을 클릭했음에도, 정상적으로 변경사항이 기록되지 않았습니다. 이를 더 자세히 살펴본 결과, 다시 History Button을 클릭하면 정상적으로 변경사항이 기록되었습니다. 즉, HistoryPopoverController가 초기화되기 전에, observing 관련 작업이 이루어져, 해당 문제가 발생하고 있음을 깨달았습니다. 이에, HistoryPopoverController의 기존 UI 구성, DataSource, Snapshot 구현 작업을 viewDidLoad가 아닌, init()을 통하여 미리 메모리에 올려둠으로써, 데이터 지연 반영 문제를 해결할 수 있었습니다.

## 📚 참고문서

- [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
- [firebase](https://firebase.google.com/docs/database/ios/lists-of-data?hl=ko)

--- 

## 3️⃣ STEP 3
### STEP 3 Questions & Answers
#### Q1. 비동기 처리
- firebase에서 비동기로 가져온 데이터를 CoreData에 동기화하기 위해 @escaping clousre를  두 번 사용하다 보니 정상적으로 UI를 그리기 힘들었습니다. UI를 그리는 메서드를 콜백 안에 넣어서 처리해주어야 정상적으로 View가 그려지는데 혹시 비동기를 통해 가져온 데이터를 사용해 View를 그리기 위해서는 어떤 식으로 비동기 처리를 해야 하는지 궁금합니다. 현재는 viewDidLoad에 있어야 할 네비게이션 구성, UI 구성 등과 같은 작업이 콜백 안에 들어가 있어 어색할 수 있다는 염려가 있습니다.
    
#### Q2. localDatabase 와 RemoteDatabase 동기화
- 현재 저희는 CoreData와 firebase에서 가져온 데이터가 다르다면 firebase에 저장된 데이터를 모두 제거하고 CoreData에 있는 데이터를 다시 firebase에 저장해 주고 있습니다. 로컬 DB와 원격 DB를 어떤 방식으로 동기화해야 하는지 궁금합니다.
    
#### Q3. History를 위한 ViewModel
- HistoryPopoverController에 있는 Cell을 생성하기 위해서는 HistoryLog 데이터가 필요한데 혹시 이러한 경우에 HistoryPopoverController에서 사용할 ViewModel을 따로 생성해 주는 게 좋을지 궁금합니다.
