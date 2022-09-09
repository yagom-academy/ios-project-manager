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

- 2022-09-09
    - UITableViewCell UI구성 
    
## 💡 키워드

- `UIKit`
- `CoreData`,`Realm`
- `CloudKit`, `Firebase`
- `MySQL`, `MongoDB`
- `async/awiat`
- `SPM`, `Carthage`, `Cocoa Pods`
- `MVVM`, `MVVM-C`
- `TableView`, `Custom View`, `Custom PopUp Modal View`
    
## 🤔 핵심경험

- [x] UIKit / SwiftUI / RxCocoa 등 선택한 기술을 통한 UI 구현
- [x] 다양한 기술 중 목적에 맞는 기술선택
- [ ] Word wrapping 방식의 이해
- [ ] 리스트에서 스와이프를 통한 삭제 구현
- [ ] Date Picker를 통한 날짜입력

## 📱 실행 화면

|메인화면|
|:--:|
||

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
│   └── CardListView
│       ├── CardSectionView
│       ├── CardListHeaderView
│       └── CardListTableViewCell
├── ViewController
│   ├── CardListViewController
│   ├── CardEnrollmentViewController
│   └── CardDetailViewController
├── Model
│   ├── TodoListModel
│   └── CardType
├── Utility
│   └── BaseTableViewCell
└── Resources
    ├── Assets
    ├── LaunchScreen
    └── Info.plist
```

    
## 📝 기능설명

**Coordinator**
- ViewController에서 실행되던 화면 전환 기능을 담당합니다. 

        
## 🚀 TroubleShooting
    
### STEP 1

#### T1. 
    
## 📚 참고문서
- [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)

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
