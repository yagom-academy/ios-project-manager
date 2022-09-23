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
    
## 🤔 핵심경험

- [x] UIKit / SwiftUI / RxCocoa 등 선택한 기술을 통한 UI 구현
- [x] 다양한 기술 중 목적에 맞는 기술선택
- [x] Word wrapping 방식의 이해
- [x] 리스트에서 스와이프를 통한 삭제 구현
- [x] Date Picker를 통한 날짜입력
- [x] 로컬 디스크 저장 구현
- [ ] 로컬-서버 데이터 동기화 구현
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
│   └── Coordinator
│       ├── CoordinatorProtocol
│       └── MainCoordinator
├── ViewModel
│   ├── CardViewModel
│   └── CardViewModelProtocol
├── View
│   ├── CardModalView
│   │   ├── CardModalView
│   │   └── CardHistoryView
│   └── CardListView
│       ├── CardSectionView
│       ├── CardHeaderView
│       └── CardListTableViewCell
├── ViewController
│   ├── CardListViewController
│   ├── CardEnrollmentViewController
│   └── CardDetailViewController
├── Model
│   ├── CardEntity
│   ├── CardModel
│   └── CardType
├── Repository
│   ├── NetworkMonitor
│   │   └── NetworkManager
│   └── CoreData
│       ├── DataService
│       ├── Firebase
│       │   └── FirebaseSerivce
│       └── Realm
│           ├── CardLocalDataEntity
│           └── RealmService
├── Utilities
│   └── Cell
│       └── ReuseIdentifying
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
- Local Data와 Remote Data의 동기화 과정에서 필요합니다. 
- Remote Data를 불러올 때 필요합니다.
    
**HistoryView** 
- 데이터의 상태 값들을 해당 뷰에서 보여줍니다.(저장, 수정, 삭제)

        
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


## 📚 참고문서
- 

--- 
    
## 1️⃣ STEP 1

### STEP 1 Questions & Answers

- Empty

## 1️⃣ STEP 2

### STEP 2 Questions & Answers

#### Q1. `TableView` 인스턴스를 3개 생성까지 해야하나요?
    - 똑같이 생긴 뷰를 만들기 위해 Custom View를 생성하여 중복되는 코드를 줄였습니다. 하나의 `TableView`로 Section을 나눠서 가로로 띄울 수는 없을까요?
    - 또는 가로로 나누는 것은 유지보수 측면에서 비효율적인 것일까요?

#### Q2. Coordinator를 활용한 View 전환 방식
    - 인터넷 서칭으로 해당 기술을 추상화 하여 구현해보았습니다. 화면 전환하는 부분을 따로 관리할 수 있다는 장점에 대한 부분도 이해하였습니다.
    - 지금 제가 추상화한 부분이 잘 적용한 것일까요? 
    - Children Coordinator는 ViewController가 해제될 때를 위한 역할만 하는 것일까요?

#### Q3. `Present ActionSheet` 메서드는 Coordinator에서 관리해야하는 것일까요? 
    
#### Q4. `TableViewCell`의 `Bottom`부분에 `CALayer`를 변경하여 처리하였으나 Cell이 재사용 되는 과정에서 해당 설정이 제대로 적용되지 않았습니다. 
- **`prepareForReuse` 메서드 내에서 처리해야 하는 부분이 있는지 정확히 파악하지는 못하였습니다.**
- 이런 방식으로 CALayer를 사용한다면 Cell에서 Reuse할 수는 없을까요?
    

## 1️⃣ STEP 3

### STEP 2 Questions & Answers

#### Q1. `Present ActionSheet` 메서드는 Coordinator에서 관리해야하는 것일까요? 
    
#### Q2. `TableViewCell`의 `Bottom`부분에 `CALayer`를 변경하여 처리하였으나 Cell이 재사용 되는 과정에서 해당 설정이 제대로 적용되지 않았습니다. 
- **`prepareForReuse` 메서드 내에서 처리해야 하는 부분이 있는지 정확히 파악하지는 못하였습니다.**
- 이런 방식으로 CALayer를 사용한다면 Cell에서 Reuse할 수는 없을까요?
    
#### A2. 
