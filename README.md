# 프로젝트 관리 앱

## 프로젝트 소개
각각의 프로젝트를 관리하는 앱을 생성한다.

> 프로젝트 기간: 2022-09-05 ~ 2022-09-18</br>
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

### Week 1
    
> 2022.09.05 ~ 2022.09.09
    
- 2022.09.05
    - 기술 스택 선정

- 2022.09.06 
    - STEP1 PR

- 2022.09.07
    - STEP2 하위 STEP 분리
        - 2-1 : CoreData 구현
        - 2-2 : 기본적인 화면 구현
        - 2-3 : MVVM 구현 및 테스트 작성
        - 2-4 : 최종 완성(View Event 처리 및 ViewModel과 연결)

- 2022.09.08
    - CollectionView를 이용해 화면 구현

- 2022.09.09
    - 추석 연휴
    
### Week 2
> 2022.09.11 ~ 2022.09.18
    
- 2022.09.11
    - 기본적인 화면 구현 완료
    - STEP 2-1, 2-2 PR
- 2022.09.12, 2022.09.13
    - 휴식
- 2022.09.14
    - STEP 2-1, 2-2 리팩토링
- 2022.09.15
    - MVVM 구현
- 2022.09.16
    - View Event 처리 및 ViewModel과 연결
- 2022.09.17
    - View 및 ViewModel 분리
- 2022.09.18
    - 최종 완성
    
## 💡 키워드

- `UITableView`, `HeaderView`, `UIGraphicsImageRenderer`, `DatePicker`, `Core Data`, `SPM`, `firebase`, 'MVVM', 'Test Double'
    
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
.
├── ProjectManager/
│   ├── Model/
│   │   └── ProjectUnit
│   ├── View/
│   │   ├── MainView/
│   │   │   ├── ProjectManagerController
│   │   │   ├── ToDoViewController
│   │   │   ├── DoingViewController
│   │   │   ├── DoneViewController
│   │   │   ├── PopoverController
│   │   │   ├── ProjectManagerListCell
│   │   │   └── SectionHeaderView
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
│   │       ├── Readjustable
│   │       └── Editable
│   └── Resource/
│       ├── AppDelegate
│       ├── SceneDelegate
│       ├── NameSpace/
│       │   └── Section
│       ├── CoreData/
│       │   ├── Project+CoreDataClass
│       │   └── Project+CoreDataProperties
│       ├── Database/
│       │   ├── DatabaseError
│       │   ├── DatabaseLogic
│       │   ├── LocalDatabaseManager
│       │   └── MockDataBase/
│       │       ├── MockLocalDatabaseManager
│       │       └── InMemoryCoreDataContainer
│       └── Extension/
│           ├── ReuseableCell
│           ├── UITableView+Extension
│           ├── Date+Extension
│           ├── UIButton+Extension
│           ├── OSLog+Extension
│           └── Notification.Name+Extension
└── ProjectManagerTests/
    └── ProjectManagerTests
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
    - 3개의 Table View를 각각의 View Controller로 구현
        - 각각의 Table View에서 사용하는 ViewModel이 다르다고 판단(TODO, DOING, DONE에서 사용하는 데이터 및 기능이 다르다.)
    - Table View의 header로 사용할 Custom View 구현
    
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
    
## 🚀 TroubleShooting

### STEP 2-1
### STEP 2-2
### STEP 2-3
### STEP 2-4
#### T1. InMemory 방식의 Core Data의 invalid fetch request 문제
- OnDisk 방식에서의 Core Data Manager에 대하여 Popover내 버튼 클릭으로 인한 프로젝트 이동 구현 시, Core Data를 업데이트 하는 과정에서는 아무런 문제가 발견되지 않았습니다. 그러나, InMemory 방식의 Core Data Manager에서는 각각의 섹션으로부터 프로젝트를 이동시킬 때마다, invalid fetch request 에러가 발견되었습니다. 디스크 저장 방식에서는 정상적으로 작동되나, 메모리 저장 방식에서 비정상적으로 작동되는 원인을 살펴본 결과, 아래와 같이 각각의 Core Data Manager 인스턴스를 만들었기 때문에, 각 섹션에 고유한 저장소를 사용한 것이었습니다. 이에, 싱글턴 인스턴스를 생성하여, 공통된 Core Data Manager를 사용함으로써, 오류를 해결할 수 있었습니다.

- 수정 전 코드
```swift
final class ToDoViewController {
    private let viewModel = ToDoViewModel(databaseManager: MockLocalDatabaseManager())
    ...
}

final class DoingViewController {
    private let viewModel = DoingViewModel(databaseManager: MockLocalDatabaseManager())
    ...
}

final class DoneViewController {
    private let viewModel = DoneViewModel(databaseManager: MockLocalDatabaseManager())
    ...
}
```

- 수정 후 코드
```swift
final class ToDoViewController {
    private let viewModel = ToDoViewModel(databaseManager: MockLocalDatabaseManager.shared)
    ...
}

final class DoingViewController {
    private let viewModel = DoingViewModel(databaseManager: MockLocalDatabaseManager.shared)
    ...
}

final class DoneViewController {
    private let viewModel = DoneViewModel(databaseManager: MockLocalDatabaseManager.shared)
    ...
}
```

    
## 📚 참고문서

- [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
    
--- 
    
## 2️⃣ STEP 2-1, 2-2

### STEP 2-2 Questions & Answers

#### Q1. Collection View의 Section 가로 배치 문제
- Collection View로 Section을 추가할 경우 세로 방향으로 추가되는 걸 확인했습니다. FlowLayout을 사용할 경우 scroll 방향을 horizontal로 해주면 가로 방향으로 추가되는 걸 확인할 수 있었지만 Section 별로 스크롤 방향을 주는 방법이 어려웠습니다. 
혹시 이번 프로젝트의 View를 구현할 때 어떠한 방법을 주로 사용하는지 궁금합니다.
    
#### A1. Collection View의 Section 가로 배치 문제
- 코멘트에 따르면, 현재 프로젝트 형태의 뷰는 table view를 여러 개를 주로 사용하여 구현한다고 합니다. 이를 통해 table view마다 독립된 data source가 존재하니 관리하기 편하다는 장점을 얻을 수 있습니다.
    
#### Q2. TextView Shadow 적용 문제
    
- UITextField의 경우에는 아래의 코드와 같이 layer에 shadow를 넣어주기만 하면 정상적으로 작동하였습니다.
    
```swift
private let scheduleTitleTextField: UITextField = {
        let textField = UITextField()
        ...
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowColor = UIColor.gray.cgColor
        
        return textField
}()
```
    
- 이와 달리, UITextView의 경우에는 위와 동일한 방법으로 layer에 shadow를 적용하였으나, shadow가 정상적으로 화면에 표시되지 않는 문제를 발견하였습니다. 이를 해결하기 위하여 처음에는 clipsToBounds 프로퍼티를 true로 설정하면, 정상적으로 shadow가 표시되나 TextView의 내용이 길어지면, 위에 있는 글자가 TextView를 벗어나는 에러를 발견하였습니다. 
- 현재는 이를 해결하기 위한 다른 방법으로 UIView를 하나 생성하여 shadow를 적용하고, 그 위에 TextView를 addSubview메서드를 통해 추가하였습니다.
- 별도의 UIView 생성 없이 TextView 자체에 shadow를 정상적으로 적용하기 위한 방법이 있을지 질문드리고 싶습니다.
- 추가로, UITextField와 UITextView의 차이가 아래의 View Hierarchy에서의 위치에서 비롯되는 것일지 의문이 듭니다.
- ![](https://i.imgur.com/ZOXcoL2.jpg)
    
#### A2. TextView Shadow 적용 문제
- UITextField는 적은 양의 텍스트를 입력 받는 도구로 설계되어 스크롤 기능이 없습니다. 그래서 요소의 크기가 예측가능하여 기본적으로 clipsToBounds가 false로 설정되어 있습니다. 반면 UITextView는 기본적으로 스크롤 기능을 제공하며, 이 기능이 기본적으로 활성화되어 있습니다. 요소의 크기가 내부에 존재하는 요소의 크기와 관계가 없으므로 기본적으로 clipsToBounds가 true로 설정되어 있습니다 (그러니 clipsToBounds를 false로 설정하고 글자가 UI 영역 밖으로 나가는 것은 에러가 아닙니다). 여러분들이 적용하신 방법대로 UITextView를 이용하려면 스크롤 기능을 비활성화하여 self-sizing text view를 구성하면 되고, 지금처럼 text view 자체가 스크롤 가능하면서 shadow를 적용하려면 현재와 같은 방법을 사용하시면 됩니다.

## 2️⃣ STEP 2-3, 2-4
### STEP 2-3 Questions & Answers
#### Q1. ViewModel과 ViewController 분리
- 하나의 ViewModel과 ViewController에서 각각 분리한 이유: 
    1. 분기 처리가 많아 코드가 복잡해짐
    2. 하나의 ViewModel이 3개의 data를 가지고 있는 게 어색함
    3. ViewController(View)의 코드가 너무 길어짐
- 각각 하나의 ViewModel과 ViewController를 사용했으나, 분기 처리가 많아 TableView 하나를 하나의 ViewController로 사용하고 해당 View(ViewController)에서 사용할 ViewModel을 따로 구현했습니다. 분기 처리는 하지 않지만 똑같은 코드가 여러 곳에서 사용되다 보니 이상하다는 느낌이 들었습니다. 또한 ViewController를 여러개 생성해서 구현하는게 어색하다고 생각했습니다. 이에 대하여 라이언의 의견을 여쭈어보고 싶습니다!
    
#### Q2. ViewModel Test Code
- ViewModel에 대한 Test Code를 구현했지만 Observable의 클로저가 잘 호출되는지 확인하기 위해 관찰하고 있는 data가 변할 때마다 전역변수로 선언해 준 count를 1씩 증가시켰습니다. ViewModel에서 구현한 클로저를 test 하는 방법이 궁금합니다. 또한 ViewModel 어떤 방식으로 Test 하는지 감이 오질 않습니다.
    
### STEP 2-4 Questions & Answers
#### Q1. InMemory 방식의 Core Data에 관한 Singleton 생성 고민
- STEP 2-4 TroubleShooting에 언급한 바와 같이, InMemory 방식의 Core Data의 경우, 각각의 섹션 뷰 컨트롤러에 대하여 싱글턴 객체를 사용하여 공통된 Core Data Manager를 설정해보았습니다. 이에 대하여 해당 해결방법이 적절한 방식이었는지, 그리고 이보다 더 좋은 방법은 무엇이 있을지 질문드리고 싶습니다!
#### Q2. InMemory 방식의 Core Data 유닛 테스트 방법 고민
- InMemory 방식의 Core Data에 대하여 sut를 `ToDoViewModel(databaseManager: MockLocalDatabaseManager.shared`로 설정을 하면, `func test_viewModel이_코어데이터에_저장된_projectUnit을_정상적으로_삭제하는지_테스트()` 메서드가 위에서 실행된 `func test_viewModel이_projectUnit을_정상적으로_코어데이터에_저장하는지_테스트()`메서드로 인한 Core Data에 저장된 값이 영향을 미치고 있음을 확인하였습니다.
- 이로 인하여, sut를 `ToDoViewModel(databaseManager: MockLocalDatabaseManager()`와 같이, 싱글톤 객체가 아닌 인스턴스를 생성한 결과, 각각 독립적인 테스트가 적용된 것 같습니다. InMemory 방식에서의 테스트를 어떻게 적용해야 하는지 조언을 구하고 싶습니다.
