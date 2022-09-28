# 프로젝트 관리 앱 저장소

## 프로젝트 소개
프로젝트를 Todo List를 통해서 관리할 수 있게 합니다.

> 프로젝트 기간: 2022-09-05 ~ 2022-09-16 (11 days) </br>
리뷰어: [웨더](https://github.com/SungPyo)</br>

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [⏱ TimeLine](#-TimeLine)
- [💡 키워드](#-키워드)
- [🤔 핵심경험](#-핵심경험)
- [📱 실행 화면](#-실행-화면)
- [🗂 폴더 구조](#-폴더-구조)
- [📝 기능설명](#-기능설명)
- [🚀 TroubleShooting](#-TroubleShooting)
- [📚 참고문서](#-참고문서)


## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|데릭|
|:---:|
|<image src = "https://avatars.githubusercontent.com/u/59466342?v=4" width="250" height="250">
|[데릭](https://github.com/derrickkim0109)|

## ⏱ TimeLine

### Week 1
    
> 2022-09-05 ~ 2022.09.09
    
- 2022-09-06
	- 프로젝트에 필요한 기능 검색 및 결정 
    
- 2022-09-07
	- Step 01 PR
    - MVVM - Coordinator 적용
    - 폴더 구조 설정
    
- 2022-09-08
    - UITableViewCell UI구성 
    - Modal View 구성

- 2022-09-09
    - Modal View UI에러 수정
    
### Week 2
    
> 2022-09-12 ~ 2022.09.16
    
- 2022-09-12
	- ModalView ViewController에 연결 
    
- 2022-09-13
	- ViewModel 작업
    
- 2022-09-14
    - 중복되는 코드 리팩토링 및 UI에러 수정

- 2022-09-15
    - UI에러 수정
    - Step02 PR
    
- 2022-09-16
    - Readme 작성 
    - Error 수정
    
### Week 3
    
> 2022-09-21 ~ 2022.09.23
    
- 2022-09-21
    - PR 피드백 수정

- 2022-09-22
    - Realm 폴더화 및 SPM 추가
    
- 2022-09-23
    - Realm 기능 구현
    - Readme 작성
    - Firebase 기능 구현
    
### Week 4
    
> 2022-09-26 ~ 2022.09.30
        
- 2022-09-26
    - Remote와 Local Storage를 위한 Repository 구현
    - History View 구현

- 2022-09-27
    - Step02 피드백 반영 및 Merge 

- 2022-09-28
    - 폴더 정리 및 ViewModel 분리 
    - Step 03 PR
    
## 💡 키워드

- `UIKit`
- `CoreData`,`Realm`, `Firebase`
- `CloudKit`, `Firebase`
- `MySQL`, `MongoDB`
- `async/awiat`
- `SPM`, `Carthage`, `Cocoa Pods`
- `MVVM`, `MVVM-C`
- `TableView`, `Custom View`, `Custom PopUp Modal View`
- `popoverPresentationController`
- `layoutSubviews`, `draw`
- `Clean Architecture`
    
## 🤔 핵심경험

- [x] UIKit / SwiftUI / RxCocoa 등 선택한 기술을 통한 UI 구현
- [x] 다양한 기술 중 목적에 맞는 기술선택
- [x] Word wrapping 방식의 이해
- [x] 리스트에서 스와이프를 통한 삭제 구현
- [x] Date Picker를 통한 날짜입력
- [x] 로컬 디스크 저장 구현
- [x] 로컬-서버 데이터 동기화 구현
- [ ] 지역화(localization) 구현
- [ ] Local Notification의 활용
- [ ] Undo Manager의 활용
    
## 📱 실행 화면

|Main|Card EnrollmentView|Card DetailView|
|:--:|:--:|:--:|
||||

|Card Delete Swipe|LocalData|RemoteData|
|:--:|:--:|:--:|
||||
    
|Networking Monitor|HistoryView|Local-Server Synchronized|
|:--:|:--:|:--:|

|Localization|Local Notification|Undo Manager|
|:--:|:--:|:--:|
    


## 🗂 폴더 구조

```
├── Application
│   ├── AppDelegate
│   ├── SceneDelegate
│   ├── Domain
│   │   ├── CardHistoryModel
│   │   │   ├── CardHistoryModel
│   │   │   └── CardState
│   │   └── CardModel
│   │       ├── CardModel
│   │       └── CardType
│   └── Presentation
│       ├── Flows
│       │   └── Coordinator
│       │       ├── CoordinatorProtocol
│       │       └── MainCoordinator
│       ├── CardList
│       │   ├── ViewModel
│       │   │   ├── CardListViewCell
│       │   │   │   └── CardListItemViewModel
│       │   │   ├── CardView
│       │   │   │   ├── CardViewModel
│       │   │   │   └── CardViewModelProtocol
│       │   │   └── View
│       │   │       ├── CustomSectionView
│       │   │       │   ├── CardSectionView
│       │   │       │   └── CardHeaderView
│       │   │       ├── CardListTableViewCell
│       │   │       └── CardListViewController
│       │   ├── CardHistory
│       │   │   ├── ViewModel
│       │   │   │   ├── CardHistoryViewModel
│       │   │   │   └── CardHistoryItemViewModel
│       │   │   └── View
│       │   │       ├── CardHistoryTableViewCell
│       │   │       └── CardHistoryViewController
│       │   └── CardModal
│       │       └── View
│       │           ├── CardEnrollmentViewController
│       │           ├── CardDetailViewController
│       │           └── CardModalView
│       └── Data
│           ├── FetchError
│           └── Repository
│               ├── RepositoryService
│               ├── PersistentStorages
│               │   ├── RealmStorage
│               │   │   ├── Entity
│               │   │   │   ├── CardLocalDataEntity
│               │   │   │   └── CardHistoryDataEntity
│               │   │   ├── RealmStorage
│               │   │   └── LocalStorageProtocol
│               │   └── FirebaseStorage
│               │       ├── Entity
│               │       │   ├── CardRemoteHistoryDataEntity
│               │       │   └── CardRemoteDataEntity
│               │       ├── FirebaseStorage
│               │       └── RemoteStorageProtocol
│               └── NetworkMonitor
│                   └── NetworkMonitor
├── Utilities
│   ├── Cell
│   │   └── ReuseIdentifying
│   ├── Date+Extensions
│   └── UIViewController+Extensions
└── Resources
    ├── Assets
    ├── LaunchScreen
    └── Info.plist
```
    
## 📝 기능설명

**Coordinator**
- ViewController에서 실행되던 화면 전환 기능을 담당합니다. 

**CardSectionView**
- Title을 나타내는 HeaderView와 TableView를 Vertical StackView에 넣어둔 View입니다.
    
**ModalView**
- 리스트 등록, 수정에 필요한 Action Sheet View입니다.

**Toolbar** 
- 리스트 등록, 수정 화면에서 키보드 사용 후 키보드 내림을 위해 `Toolbar`를 사용하여 `Done` 버튼을 추가하였습니다.
    
**Keyboard올림/내림처리**
- TextView에서 키보드 사용시 전체 스크롤이 키보드 높이만큼 올라갈 수 있도록 처리하였습니다.
    
**기간 만료**
- 현재 시간을 기준으로 저장되어 있는 `deadlineDate`를 비교하여 색이 변하도록 처리하였습니다.

**Local Data**
- Local Data를 Realm 라이브러리를 통해 CRUD를 처리하였습니다.
    
**Remote Data**
- Remote Data를 Firebase를 사용하여 원격 서버로 저장하였습니다.
    
**Networking Monitoring**
- Networking 연결 유무를 확인하는 객체를 생성하였습니다.

**HistoryView** 
- 데이터 CRUD에 대한 기록들을 Local, Remote 데이터베이스로 저장하고 해당 내용들을 `HistoryView`를 통해 업데이트 합니다.
    
**RepositoryService**
- Local Data가 Remote 데이터와 저장 내용이 다를 시 Local Data에 없는 데이터를 저장합니다.
- Local & Remote Database CRUD를 복합적으로 가지고 있습니다.

## 🚀 TroubleShooting
    
### STEP 2

#### T1. CALayer를 통한 TableView Seperator 설정

**TableViewCell**
```swift
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.addBottomBorder()
```
**CALayer**
```swift
import UIKit

extension CALayer {
    func addBottomBorder() {
        let border = CALayer()
        border.backgroundColor = UIColor.systemGray6.cgColor
        border.frame = CGRect(x: 0,
                              y: frame.height,
                              width: frame.width,
                              height: 10)
        
        addSublayer(border)
    }
}

```
- `TableViewCell`의 `Bottom`부분에 `CALayer`를 변경하여 처리하였으나 Cell이 재사용 되는 과정에서 해당 설정이 제대로 적용되지 않았습니다. 
    - **`prepareForReuse` 메서드 내에서 처리해야 하는 부분이 있는지 정확히 파악하지는 못하였습니다.**

- 해결방안
**TableViewCell**
```swift 

    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()

        separator.move(to: CGPoint(x: 0, y: bounds.maxY))
        separator.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))

        UIColor.systemGray6.setStroke()
        separator.lineWidth = Const.seperatorLineWidth
        separator.stroke()
    }
```
- UIBezierPath를 통해 라인을 그려주는 것으로 해결하였습니다.
    
#### T2. Present ActionSheet  
- 어제 질문드렸던 부분입니다. `LongPressGusture`의 `selector`에서 모달을 띄워야 하는 상황이였습니다. `CardListViewController`에서 처리를 하기 위해서는 cell(UIView), model(CardModel), indexPath(TableView)를 사용하해야하는데 `selector`는 매개변수를 받을 수 없었습니다. 힌트로 UITableViewCell에서 처리하라고 말씀해주셔서 생각해 본 결과 필요한 부분이 모두 UITableViewCell에서 있었습니다..! 

- 해결방안
**TableViewCell**
```swift
     private func createActionSheet() -> UIAlertController {
        let alertViewController = UIAlertController(title: nil,
                                                    message: nil,
                                                    preferredStyle: .actionSheet)

        let (firstCard, secondCard) = distinguishCardType(of: model)

        alertViewController.modalPresentationStyle = .popover
        alertViewController.popoverPresentationController?.permittedArrowDirections = .up

        alertViewController.popoverPresentationController?.sourceView = self
        alertViewController.popoverPresentationController?.sourceRect = CGRect(x: self.contentView.frame.midX,
                                                                               y: self.contentView.frame.midY,
                                                                               width: 1,
                                                                               height: 1)
        let firstAction = UIAlertAction(title: firstCard.moveToAnotherSection,
                                        style: .default) { [weak self] _ in
            self?.viewModel?.move(self?.model,
                                  to: firstCard)
        }

        let secondAction = UIAlertAction(title: secondCard.moveToAnotherSection,
                                         style: .default) { [weak self] _ in
            self?.viewModel?.move(self?.model,
                                  to: secondCard)
        }

        alertViewController.addAction(firstAction)
        alertViewController.addAction(secondAction)

        return alertViewController
    }
```
    
### STEP 3

#### T1. 불필요하게 여러 기능을 그대로 가지고 있는 viewModel에 대한 처리
- 리뷰해주신 내용대로 ViewModel의 기능을 각 View에 맞춰서 처리할 수 있도록 하였습니다. 
    
```swift 

class CardHistoryViewModel {
    private let repositoryService = RepositoryService.shared

    var cardHistoryModelList: [CardHistoryModel] = [] {
        didSet {
            reloadHistoryTableViewClosure?(cardHistoryModelList)
        }
    }
    
    var reloadHistoryTableViewClosure: (([CardHistoryModel]) -> Void)?
    
    init() {
        fetchData()
    }

    func fetchData() {
        self.cardHistoryModelList = repositoryService.fetchCardHistoryModel().sorted {$0.date > $1.date}
    }
}
```

```swift 
class CardHistoryItemViewModel {
    private let cardHistoryModel: CardHistoryModel

    init(cardHistoryModel: CardHistoryModel) {
        self.cardHistoryModel = cardHistoryModel
    }
    
    var title: String {
        switch cardHistoryModel.cardState {
        case .added:
            return "\(cardHistoryModel.cardState.rawValue) '\(cardHistoryModel.title)'."
        case .moved:
            return "\(cardHistoryModel.cardState.rawValue) '\(cardHistoryModel.title)' from \(cardHistoryModel.cardTypeDescription)."
        case .removed:
            return "\(cardHistoryModel.cardState.rawValue) '\(cardHistoryModel.title)' from \(cardHistoryModel.cardTypeDescription)."
        }
    }

    var date: String {
        let date = cardHistoryModel.date.formattedDateForUSALocale
        return date
    }
}

```
- 위의 코드를 기존에는 `CardViewModel`에서 모두 처리하고 있었으나 CardHistoryViewController에 맞게 따로 분리하여 처리하였습니다. 
- **이런 식으로 소량을 ViewModel로 처리하였을 경우에도 Test를 위한 추상화가 필요할까요?**


#### T2. ViewController가 인스턴스화 될 때 ViewModel을 주입 시켜주는 상황에서 ViewController 내의 viewModel 프로퍼티가 상수로 처리되어있지 않고 Optional처리가 되어있었습니다. 
    
```swift 
    private var viewModel: CardViewModelProtocol?
```
    
[문제점]
- viewModel이 initializer에서 할당되는 프로퍼티인데 Optional 처리되어 있는 것은 프로젝트가 커지면 커질수록 모호할 수 있다. (viewModel을 인스턴스화 시킬 수 있다는 말이다.)
    
[해결방안]
- initializer로 받는 프로퍼티들은 대부분 상수로 변경하였습니다. 하지만, mutating이 필요한 viewModel의 경우 Optional은 제거하였지만 변수 선언은 그대로 해두었습니다. **이런 경우는 이렇게 처리해도 될까요?**
    


## 📚 참고문서
- 

--- 
    
## 1️⃣ STEP 1

### STEP 1 Questions & Answers

#### Q1. `TableView` 인스턴스를 3개 생성까지 해야하나요?
    - 똑같이 생긴 뷰를 만들기 위해 Custom View를 생성하여 중복되는 코드를 줄였습니다. 하나의 `TableView`로 Section을 나눠서 가로로 띄울 수는 없을까요?
    - 또는 가로로 나누는 것은 유지보수 측면에서 비효율적인 것일까요?

#### Q2. Coordinator를 활용한 View 전환 방식
    - 인터넷 서칭으로 해당 기술을 추상화 하여 구현해보았습니다. 화면 전환하는 부분을 따로 관리할 수 있다는 장점에 대한 부분도 이해하였습니다.
    - 지금 제가 추상화한 부분이 잘 적용한 것일까요? 
    - Children Coordinator는 ViewController가 해제될 때를 위한 역할만 하는 것일까요?

## 1️⃣ STEP 2

### STEP 2 Questions & Answers

#### Q1. `Present ActionSheet` 메서드는 Coordinator에서 관리해야하는 것일까요? 
    
#### Q2. `TableViewCell`의 `Bottom`부분에 `CALayer`를 변경하여 처리하였으나 Cell이 재사용 되는 과정에서 해당 설정이 제대로 적용되지 않았습니다. 
- **`prepareForReuse` 메서드 내에서 처리해야 하는 부분이 있는지 정확히 파악하지는 못하였습니다.**
- 이런 방식으로 CALayer를 사용한다면 Cell에서 Reuse할 수는 없을까요?
    
#### A2. 

    
## 1️⃣ STEP 3

### STEP 3 Questions & Answers
    
#### Q1. `Repository`에서 생길 수 있는 error를 ViewModel로 가져오려면 어떻게 해야 할까요?
- `RealmService`와 `FirebaseService`의 데이터 처리가 서로 중복되는 부분이 있어 Repository라는 객체를 만들었습니다. 하지만 아래와 같은 코드에서는 어떻게 error를 처리해야할지 감이 잡히지 않습니다.. 
```swift 
final class RepositoryService {
    init() {
        synchronizeData()
    }
    private func synchronizeData() {
        let localData = self.realmService.fetchCardModel()
        Task {
            let romoteData = try await firebaseService.fetchCardModel()
            self.combine(between: localData,
                         and: romoteData)
        }
    }
}
```
    
- 제가 원했던 부분은 `Repository` 클래스가 인스턴스화 될 때 `Realm` 저장소와 `Firebase`저장소의 데이터가 다를 시 `Realm`으로 데이터를 저장 시키기 위해서 위와 같이 처리해보았습니다. 해당 부분은 `Repository`라는 객체를 두지 않고 `CardViewModel`에서 처리되어야 하는 것일까요?
    
#### Q2. 위의 `Repository` 클래스의 연장 질문입니다. `Card`가 저장되고 업데이트 되는 내용들이 `Realm` 저장소에 저장되는데 `View`에 업데이트 하기 위한 데이터는 `Realm vs Firebase`중 어떤것을 기준으로 두는 것이 좋을까요? 안정적인 측면에서 네트워크가 필요없는 Realm을 기준으로 처리하였습니다.

#### Q3. 기존에 있던 CardViewModel의 기능 중 `CardListTableViewCell`에 필요한 ViewModel을 따로 생성해 주었습니다. 먼저 제가 구현한 내용이 맞는지가 궁금합니다.!
또 한가지 문제점이 있다면 ViewModel을 여러개 만들어 줌으로써 파일을 디렉토리별로 나누기가 곤란하게 되었습니다. 다른 블로그에 있는 Clean Architecture를 참고하며 구조 변경을 조금 해보았습니다. 하지만, 또 다른 문제점은 Domain에서 Usecase를 나누는 점과 Clean Architecture로 처리하기엔 지금 제 코드의 문제점들이 너무 많아 보입니다.. 너무 모호한 질문이지만.. 어떻게 리팩토링 하는게 나을까요..?

#### Q4. CardViewController에서 선언되어 있던 TableViewDelegate를 SectionView로 옮기는 작업
    - 작업이 많아질수록 ViewController의 코드가 계속해서 늘어났습니다. 
    - View로 옮기는 작업 중 문득 든 생각은 View에게 ViewModel의존성을 부여해서 ViewController에게 viewModel이 처리하는 일들을 모두 넘기는게 맞을까요? 지금 제가 구현한 코드는 조금 역할이 애매모호한 것 같습니다. 하지만 TableView를 세 개로 나눠 reaload클로저를 어떻게 활용해야할지 감이 잡히지 않습니다..그냥 두는게 나을까요? 