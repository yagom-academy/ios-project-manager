# 💻 프로젝트 매니저

## 🪧 목차
- [📜 프로젝트 소개](#-프로젝트-소개)
- [📱 실행 화면](#-실행-화면)
- [💡 핵심경험](#-핵심경험)
- [🗂 폴더 구조](#-폴더-구조)
- [🧑‍💻 코드 설명](#-코드-설명)
- [🔗 참고 링크](#-참고-링크)

<br>

## 📜 프로젝트 소개
내가 해야할 일을 진행도 별로 나누어 보여주는 앱입니다 

> 프로젝트 기간: 2022-09-04 ~ 2022-09-30</br>
> 팀원: [백곰](https://github.com/Baek-Gom-95) </br>
리뷰어: [토니](https://github.com/Monsteel)</br>

<br>

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[백곰](https://github.com/Baek-Gom-95)|
|:---:|
| <img src = "https://i.imgur.com/c17eEk8.jpg" width="250" height="250"> |
	
<br>
## 📱 실행 화면
| 프로젝트 메인화면 |+ 버튼 터치 시 추가화면 |
| :--------: | :--------: |
| ![](https://i.imgur.com/K8hRmrJ.png) |![](https://i.imgur.com/svkCpB8.png)|

| 할일 추가 화면 |할일 추가후 리스트 화면 |
| :--------: | :--------: |
| ![](https://i.imgur.com/Wro7qNx.png) |![](https://i.imgur.com/0DzuCwN.png)|

| Realm 에 데이터 추가 |
| :--------: |
|![](https://i.imgur.com/IHnOyvr.png) |

<br>

## 💡 핵심경험
 
- [x] 로컬 디스크 저장 구현
- [x] 로컬-서버 데이터 동기화 구현
- [x] 지역화(localization) 구현
- [x] Local Notification의 활용
- [x]  Undo Manager의 활용

<br>


## 🗂 폴더 구조

```
.
.
├── AppDelegate.swift
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   └── Contents.json
│   └── Contents.json
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Coordinator
│   └── ApplyCoordinator.swift
├── Enum
│   ├── TodoCategory.swift
│   ├── TodoDetailButtonType.swift
│   └── TodoDetailType.swift
├── Extension
│   └── String+Extension.swift
├── Info.plist
├── ManageDatabase
│   ├── DatabaseManger.swift
│   └── RealmDatabaseManager.swift
├── Model
│   ├── TodoLocalModel.swift
│   └── TodoModel.swift
├── Protocol
│   ├── Coordinator.swift
│   ├── ReuseIdentifying.swift
│   └── TodoDatabaseManager.swift
├── SceneDelegate.swift
├── TodoDetail
│   └── TodoDetailViewController.swift
├── TodoDetailViewModel
│   └── TodoDetailViewModel.swift
├── TodoList
│   └── TodoListViewController.swift
├── TodoListView
│   ├── TodoListCell.swift
│   └── TodoListView.swift
└── TodoListViewModel
    └── TodoListViewModel.swift

```

<br>

## 🧑‍💻 코드 설명
- `ApplyCoordinator`: Coordinator 패턴을 사용해서 화면 전환을 위한 코드 입니다
- `DatabaseManager`: 데이터 베이스 관련 기능을 구현한 코드 입니다.
- `RealmDatabaseManager`: Realm 데이터 베이스 기능을 구현한 코드 입니다.
- `TodoModel`: Todo 모델입니다
- `TodoLocalModel`: Realm 모델 입니다
- `TodoListView`: TodoList 화면을 구현하는 코드 입니다.
- `TodoListCell`: TodoList에 TableCell을 구현하는 코드 입니다.
- `TodoListViewController`: TodoList 를 관리하는 컨트롤러 입니다.
- `TodoDetailViewController`: TodoDetail 을 관리하는 컨트롤러 입니다.
- `TodoListViewModel`: TodoListViewController 에서 받은 Action 처리
- `TodoDetailViewModel`: TodoDetailViewModel 에서 받은 Action 처리


<br><br>


## 🔗 참고 링크


<details>
<summary>[STEP 1]</summary>
	
[Realm](https://www.mongodb.com/docs/realm-legacy/kr/docs/swift/latest.html)<br>
[Realm 사용법 과 특징](https://velog.io/@dlskawns96/Swift-Realm%EC%9D%98-%ED%8A%B9%EC%A7%95%EA%B3%BC-%EC%82%AC%EC%9A%A9%EB%B2%95)<br>
[Firebase 연동](https://sujinnaljin.medium.com/ios-firebase-%ED%8C%8C%EC%9D%B4%EC%96%B4%EB%B2%A0%EC%9D%B4%EC%8A%A4-%EC%97%B0%EB%8F%99-56bcc972ec8f)<br>
[Firebase 사용법](https://zeddios.tistory.com/47)<br>
[DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)<br>
</details>

<details>
<summary>[STEP 2]</summary>
    
[곰튀김님 RxSwift](https://www.youtube.com/watch?v=w5Qmie-GbiA&t=7523s)<br>
[RxSwift 개념](https://ios-development.tistory.com/95)<br>
[RxSwift 란 뭘까](https://velog.io/@minji0801/RxSwift)<br>
[RxSwift Observable](https://academy.realm.io/kr/posts/how-to-use-rxswift-with-simple-examples-ios-techtalk/)<br>
[RxSwift 예제](https://duwjdtn11.tistory.com/583)<br>
</details>
