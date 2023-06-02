# 프로젝트 매니저 🔖

> **소개: 할일 List 를 만들어 일정을 관리하는 App**

## 기술스택 🛠️

| UI  | Architecture | Dependency Manager  | Concurrency |
| -- | -- | -- | -- | 
| SwiftUI |  MVVM | SPM | Combine |

### 프로젝트 핵심 경험
- SwiftUI 기반의 View 그리기
- DatePicker
- ContextItem 을 이용한 데이터 이동
- SwiftUI의 onDelete를 이용한 삭제 기능
- 다양한 기술 중 목적에 맞는 기술선택

</br>

## 목차
1. [팀원](#1-팀원)
2. [타임라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행-화면)
5. [트러블슈팅](#5-트러블-슈팅)
6. [참고링크](#6-참고-링크)

<br>

## 1. 팀원

|[<img src="https://i.imgur.com/IOAJpzu.png" width="22"/> 릴라](https://github.com/juun97)| [<img src="https://i.imgur.com/IOAJpzu.png" width="22"/> kaki](https://github.com/kak1x) |
| :--------: | :--------: |
|<img height="180px" src="https://camo.githubusercontent.com/77386a16d7bcde407f51b2f5f643f9a49d9b73db7a460e09f3b367e1d466e521/68747470733a2f2f692e696d6775722e636f6d2f533454536d70482e706e67">| <img height="180px" src="https://i.imgur.com/KkFB7j3.png"> |

<br>

## 2. 타임라인
#### 프로젝트 진행 기간 : 23.05.15 (월) ~ 23.06.02 (금)

| 날짜 | 타임라인 |
| --- | --- |
|23.05.15 (월)| 프로젝트 타겟 버전 설정 |
|23.05.16 (화)| 프로젝트에 사용할 기술 선정 및 패키지 추가 |
|23.05.17 (수)| MainView, ListView, ModalView 등 기본적인 뷰 구현 |
|23.05.18 (목)| Cell 모양 잡기, ModalView 띄우기 구현 |
|23.05.19 (금)| 디자인 패턴 및 Combine 학습 |
|23.05.22 (월)| 디자인 패턴 및 Combine 학습 |
|23.05.23 (화)| ViewModel 구현, 전체적인 네이밍 수정 |
|23.05.24 (수)| List를 선택할시 Popover를 띄워 항목간 이동 기능 구현 |
|23.05.25 (목)| Popover가 부자연스럽게 작동하는 문제 발견 및 해결 방안 논의 |
|23.05.26 (금)| Popover에서 ContextMenu로 변경, 셀 클릭시 ModelView 띄우기 및 ModalView의 EditMode 체크 기능 구현 |
|23.05.28 (일)| Cell에 move, delete 기능 사용시 버벅이는 현상 해결, State에 따른 개별 List에서 하나의 List로 통합 및 리팩토링 |
|23.05.29 (월)| 접근제어 설정 및 View 분리, 컨벤션 수정 |
|23.05.31 (수)| EnvironmentObject로 갖고 있던 ViewModel을 State와 Binding으로 변경 |
|23.06.01 (목)| List의 SectionView 분리, State로 갖고 있던 ViewModel을 ObservedObject로 변경 |
|23.06.02 (금)| README작성 |

<br>

## 3. 프로젝트 구조


#### **폴더구조**

``` swift
ProjectManager
    ├── App
    |    └── ProjectManagerApp
    ├── Model
    |    ├── Project
    |    └── ProjectState
    ├── View
    |    ├── MainView
    |    │    ├── ProjectMainView
    |    │    ├── ProjectListView
    |    │    ├── ProjectListHeaderView
    |    │    ├── ProjectListSectionView
    |    │    ├── ProjectListContextMenuView
    |    │    └── ProjectListCell
    |    └── ProjectDetailView
    ├── ViewModel
    |    └── ProjectViewModel
    ├── Utill
    |    ├── DateManager
    |    └── Array+Extension
    ├── Assets
    ├── GoogleService-Info
    └── Preview Content
         └── Preview Assets
```

</br>



## 4. 실행 화면

|**신규 저장**|**셀 클릭시 상세 정보**|**기존 정보 수정**|
|:-----:|:-----:|:-----:|
| <img src = "https://github.com/juun97/ios-diary/assets/59365211/ae395310-488a-4b30-a24a-5ccd23add0e5" width = "300">|<img src = "https://github.com/juun97/ios-diary/assets/59365211/80c9d079-bc12-4271-a80d-8e8379229c18" width = "300"> |<img src = "https://github.com/juun97/ios-diary/assets/59365211/6ce1dda2-ed72-42a3-91c4-5e31496ba4b2" width = "300">|

|**항목 이동**|**스와이프 삭제**|
|:-----:|:-----:|
| <img src = "https://github.com/juun97/ios-diary/assets/59365211/d88c9d3b-76d5-434b-92d7-4b48f2b70939" width = "300">|<img src = "https://github.com/juun97/ios-diary/assets/59365211/f89c5831-58a9-4092-94af-22f897ed0f7a" width = "300"> |


<br>

## 5. 트러블 슈팅

### 1️⃣ ViewModel 의 데이터 관리

- 처음 시도해본 방식은 각각의 `state` 에맞는 `List` 를 만들어 사용을 하는것이었습니다.

- 위 방법을 사용할 시 각각의 리스트View 에서 자신의 state 에 맞는 List를 넘겨주기만 하면 간편하게 사용이 가능하단 이점이 있었습니다. 하지만 뷰모델이 여러개의 List 를 가지고 있었기에 관리측면에서는 몇몇 어려운점이 있었습니다.

#### 원본데이터의 접근
- 현재 ViewModel 을 environmentObject 로 관리를 하고 있습니다. 만약 데이터의 변경이 일어났다면 viewModel 을 관찰하고 있는 모든 View 들이 바뀌어야 했기에 원본데이터의 접근이 필수불가피 했습니다.

#### 조건에 맞는 분기처리
- viewModel 이 관리하고 있는 list 들이 여러개 였기에 자신의 state와 만약 이동을 해야할 경우 이동할 state 에 맞는 list 를 알아야 했습니다.

- 개발자의 입장에서는  이 state는 맞는 list는 저 list다" 라는것을 알지만 시스템은 알지 못했기에, 조건에 맞는 분기처리를 모두 진행해야 했습니다.

### ⚒️ 해결방법

- 이를 해결 하기위해 기존의 state에 맞는 list를 여러개 만드는것이 아닌 하나의 list 에서 관리를 하는 방식을 사용하기로 했습니다.

- list의 element 에 state 프로퍼티를 사용하게 해 하나의 List 에서 state에 맞는 List 를 구분할 수 있도록 했습니다.

- 이 방법을 사용하니 우리가 접근해야할 원본데이터인 list 가 하나이기에 별도의 분기처리 없이 수월하게 접근을 할 수 있게 되었고, 코드의 길이또한 기존코드에 비교하면 대략 1/5 정도로 줄게되었습니다.

<br>

## 6. 참고 링크
- [Introducing SwiftUI: Building Your First App - WWDC19](https://developer.apple.com/videos/play/wwdc2019/204/)
- [SwiftUI Essentials - WWDC19](https://developer.apple.com/videos/play/wwdc2019/216/)
- [Data Flow Through SwiftUI - WWDC19](https://developer.apple.com/videos/play/wwdc2019/226/)
- [Developer Apple - State](https://developer.apple.com/documentation/swiftui/state)
- [Developer Apple - Binding](https://developer.apple.com/documentation/swiftui/binding)
