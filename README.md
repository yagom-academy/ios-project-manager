# 프로젝트 관리앱 README.md
## 프로젝트 저장소
> 프로젝트 기간: 2022-09-05 ~ 2022-09-16</br>
> 팀원: [그루트](https://github.com/Groot-94)</br>
리뷰어: [제이크](https://github.com/jryoun1)</br>
## 📑 목차
- [개발자 소개](#개발자-소개)
- [프로젝트 소개](#프로젝트-소개)
- [UML](#UML)
- [폴더 구조](#폴더-구조)
- [구현화면](#구현화면)
- [키워드](#키워드)
- [핵심경험](#핵심경험)
- [기능설명](#기능설명)
- [프로젝트 후기](#프로젝트_후기)
- [TroubleShooting](#TroubleShooting)
- [1️⃣ Step1 Wiki](#1️⃣-Step1-Wiki)
- [2️⃣ Step2 Wiki](#2️⃣-Step2-Wiki)
## 개발자 소개
|그루트|
|:---:|
| <img src = "https://i.imgur.com/onBeySC.jpg" width="250" height="250"> |
|[그루트](https://github.com/Groot-94)|
## 프로젝트 소개
- 로컬, 리모트 DB를 통해 프로젝트(제목, 내용, 기한)를 관리할 수 있는 프로젝트 매니저 앱

## UML

### ClassDiagram
![](https://i.imgur.com/2QKDW7n.png)
## 폴더 구조
```
├── ProjectManager
│   ├── ProjectManager
│   │   ├── AppDelegate
│   │   │   └── AppDelegate.swift
│   │   ├── Base.lproj
│   │   ├── Extension
│   │   │   └── Date+Extension.swift
│   │   ├── Info.plist
│   │   ├── Model
│   │   │   ├── ProjectDTO.swift
│   │   │   └── ProjectState.swift
│   │   ├── Resource
│   │   │   └── Assets.xcassets
│   │   │       ├── AccentColor.colorset
│   │   │       │   └── Contents.json
│   │   │       ├── AppIcon.appiconset
│   │   │       │   └── Contents.json
│   │   │       └── Contents.json
│   │   ├── Util
│   │   │   ├── Observer.swift
│   │   │   ├── ProjectDAO.swift
│   │   │   ├── ProjectDataManager.swift
│   │   │   └── ProjectDataManagerProtocol.swift
│   │   ├── View
│   │   │   ├── Base.lproj
│   │   │   │   └── LaunchScreen.storyboard
│   │   │   ├── Scene
│   │   │   │   ├── ProjectDataManager
│   │   │   │   │   ├── ProjectDataManagerView.swift
│   │   │   │   │   └── ProjectDataManagerViewController.swift
│   │   │   │   └── ProjectManagerList
│   │   │   │       ├── ProjectManagerViewController.swift
│   │   │   │       ├── ProjectTableHeaderView.swift
│   │   │   │       ├── ProjectTableView.swift
│   │   │   │       └── ProjectTableViewCell.swift
│   │   │   └── SceneDelegate.swift
│   │   └── ViewModel
│   │       └── ProjectViewModel.swift
│   └── ProjectManager.xcodeproj
│       ├── project.pbxproj
│       ├── project.xcworkspace
│       │   ├── contents.xcworkspacedata
│       │   ├── xcshareddata
│       │   │   ├── IDEWorkspaceChecks.plist
│       │   │   └── swiftpm
│       │   └── xcuserdata
│       │       └── NAMU.xcuserdatad
│       │           └── UserInterfaceState.xcuserstate
│       ├── xcshareddata
│       │   └── xcschemes
│       │       └── ProjectManager.xcscheme
│       └── xcuserdata
│           └── NAMU.xcuserdatad
│               ├── xcdebugger
│               │   └── Breakpoints_v2.xcbkptlist
│               └── xcschemes
│                   └── xcschememanagement.plist
└── README.md
```
## 구현화면
||
|:---:|
|프로젝트 추가 화면||
| <img src = "https://i.imgur.com/IHQMv8X.gif" width="800" height="500">|
|프로젝트 상태 이동 화면||
| <img src = "https://i.imgur.com/i74yEzg.gif" width="800" height="500">|
|프로젝트 편집 화면||
| <img src = "https://i.imgur.com/Ay55tR5.gif" width="800" height="500">|
|프로젝트 삭제 화면||
| <img src = "https://i.imgur.com/iUfo9mg.gif" width="800" height="500">|
## 키워드
- Remote Database
- Realm
- CoreData
- Date Picker
- TableView
- Design Pattern
- Localization
## 핵심경험
- [x] 로컬과 리모트(클라우드)의 데이터 동기화 및 로컬 데이터 저장을 위한 적합한 기술을 선정하기 위해 기술에 대한 조사와 차이점 분석 후 선정해보는 경험을 할 수 있었다.
- [x] 기술선정에 대한 기준을 고민해볼 수 있었다.
- [x] MVVM, MVC 등 Disign Pattern에 어떤 차이가 있는지 고민해보고 적용해보는 경험을 할 수 있었다. 
## 기능설명
- 전반적인 리팩토링 중
## 프로젝트_후기
- 프로젝트 종료 후 작성예정
## TroubleShooting
### 🔗 Singleton pattern 지양하고 여러 ViewController에서 Data 처리를 어떻게 할 지.
- 아래와 같은 이유로 가능하면 Singleton pattern을 사용하지 않기 위해서 고민을 했습니다.
    1. Singleton pattern을 사용해 클래스간 결합도가 높아지게 되면, 유지보수가 힘들고 테스트도 원활하게 진행할 수 없는 문제점이 발생한다.
    2. 멀티 스레드 환경에서 동기화 처리를 하지 않았을 때, 인스턴스가 2개가 생성되는 문제도 발생할 수 있습니다.
- UpdateViewController를 분리하면서 Data 처리를 어떻게 할 지 고민을 하다 Delegate pattern을 사용해서 처리하였습니다.
### 🔗 TextView 클릭 시 나타나는 경고메세지.
- TextView를 클릭 시 아래와 같은 경고가 나타났습니다.
![](https://i.imgur.com/TriXZCY.png)

![](https://i.imgur.com/FfQPwvq.png)
- 이 문제를 해결하기 위해 WTF에 메세지를 입력해봤으나 이해할 수 없어서 `TUISystemInputAssistantView` 키워드 검색을 통해 StackOverFlow에서 관련 문제에 대해 찾았습니다.

`The layout constraint error message has nothing to do with your layout.
It's an internal issue (could be considered a bug) with the Input Assistant View - the auto-complete options shown above the keyboard.`

- 자동완성 뷰 내부에서 생기는 문제라는 글을 보고 텍스트 뷰에 **textView.autocorrectionType = .no** 옵션을 추가하여 경고창이 뜨지 않도록 했습니다.

[참고사이트](https://stackoverflow.com/questions/61687035/swift-textfields-always-show-layout-constraint-error)

## [1️⃣ Step1 Wiki](https://github.com/Groot-94/ios-project-manager/wiki/Step1---%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4,-%EA%B8%B0%EC%88%A0%EC%8A%A4%ED%83%9D-%EC%84%A0%EC%A0%95)
## [2️⃣ Step2 Wiki](https://github.com/Groot-94/ios-project-manager/wiki/Step2---%EC%95%B1-%ED%99%94%EB%A9%B4-%EB%B0%8F-%EA%B8%B0%EB%8A%A5-%EA%B5%AC%ED%98%84)
