# 📱 프로젝트 매니저 📱

> 프로젝트 기간: 2023-01-09 ~ 2023-01-27 (3주)

## 🗒︎목차

1. [소개](#-프로젝트-소개)
2. [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
3. [팀 ](#-팀-소개)
4. [타임라인](#-타임라인)
5. [파일 구조](#-파일-구조)
6. [프로젝트 구조](#-프로젝트-구조)
7. [실행화면](#-실행-화면)
8. [트러블 슈팅](#-트러블-슈팅)
9. [고민한 점](#-고민한-점)
10. [참고링크](#-참고-링크)

---

## 👋 프로젝트 소개
할일을 정리할 때 유용한 프로젝트 관리 어플입니다.
할일을 추가, 삭제, 변경은 기본! 할일의 상태(todo, doing, done)으로 나누어 관리가 가능합니다.

---

## 💻 개발환경 및 라이브러리

[![swift](https://img.shields.io/badge/swift-5.7-orange)]() [![iOS](https://img.shields.io/badge/iOS-16.2-blue)]() 

## 기술스택
|Framework|Architecture|Asynchronous|Network|LocalDB|RemoteDB|Dependency Manager|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|<img src="https://img.shields.io/badge/UIkit-2396F3?style=flat-square&logo=Uikit&logoColor=white"/></a> | <img src="https://img.shields.io/badge/MVC-792EE5?style=flat-square&logo=&logoColor=white"/></a> | <img src="https://img.shields.io/badge/GCD/Operation-A5CD39?style=flat-square&logo=&logoColor=white"/></a> | <img src="https://img.shields.io/badge/URLSession-EE6123?style=flat-square&logo=&logoColor=white"/></a> |<img src="https://img.shields.io/badge/CoreData-41454A?style=flat-square&logo=Apple&logoColor=white"/></a>|<img src="https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=FireBase&logoColor=white"/></a> | <img src="https://img.shields.io/badge/CocoaPods-EE3322?style=flat-square&logo=CocoaPods&logoColor=white"/></a>|

---

## ☁️ 팀 소개
|[som](https://github.com/jsa0224)|
|:---:|
|<img src = "https://i.imgur.com/eSlMmiI.png" width = 300>|

---

## 🕖 타임라인

### Step 1
 - **23.01.10**
    - [기술스택](#-기술스택) 정하기
    - Firebase 라이브러리 추가 [![feat](https://img.shields.io/badge/feat-green)]()

### Step 2
 - **23.01.16**
   - UML로 만들었던 아키텍처 프로젝트에 반영 [![feat](https://img.shields.io/badge/feat-green)]()
   - MockData 추가 및 PlanListViewController에 적용 [![feat](https://img.shields.io/badge/feat-green)]()
   - 마감일과 현재 날짜를 비교하는 메서드 구현 [![feat](https://img.shields.io/badge/feat-green)]()
 - **23.01.18**
   - PlanManager의 CRUD 구현 [![feat](https://img.shields.io/badge/feat-green)]()
   - headerView와 popover 구현 [![feat](https://img.shields.io/badge/feat-green)]() 
 - **23.01.19**
   - textView의 placeholder 구현 [![feat](https://img.shields.io/badge/feat-green)]()
   - AlertManager 생성 및 각각의 ViewController에 alert 구현 [![feat](https://img.shields.io/badge/feat-green)]()
---

## 💾 파일 구조
```
ProjectManager
├── App
│   ├── AppDelegate
│   └── SceneDelegate
└── Source
    ├── Common
    │   ├── PlanManageable
    │   ├── PlanManager
    │   ├── CellReusable
    │   ├── DateFormatterManager
    │   ├── AlertManager
    │   └── Namespace
    ├── Model
    │   ├── MockData
    │   └── Plan
    ├── View
    │   ├── PlanTableViewCell
    │   ├── PlanTableView
    │   ├── PlanListHeaderView
    │   ├── PlanListView
    │   └── PlanDetailView
    └── Controller
        ├── PlanListViewController
        └── PlanDetailViewController
```


---

## 📊 프로젝트 구조
![](https://i.imgur.com/koY8rk4.jpg)

---

## 💻 실행 화면
|할일 상태 변경|
|:---:|
|![](https://i.imgur.com/BaQllbP.gif)|

|할일 추가|빈 내용일 경우 저장 X|
|:---:|:---:|
|![](https://i.imgur.com/Zr3UQOL.gif)|![](https://i.imgur.com/9107pee.gif)|

|할일 수정|할일 삭제|
|:---:|:---:|
|![](https://i.imgur.com/PwNF6CU.gif)|![](https://i.imgur.com/dExxELQ.gif)|

---

## 🎯 트러블 슈팅
> 아직 리펙토링 중이라 정리되면 추후 추가될 예정일 부분입니다.

### `[weak self]` 꼭 필요할까?
![](https://i.imgur.com/LJeqNvO.png)
 
![](https://i.imgur.com/bH8KNHs.png)

위의 사진은 `[weak self]`를 할 경우, `planList`가 옵셔널 타입이 되어 `inout`이 안 되고, `inout` 키워드를 삭제할 경우 매개변수가 상수화되어 값을 바꾸는 로직에 대한 에러가 일어나는 상황입니다.

그래서 `[weak self]`가 꼭 클로저에 필요할까? 라는 생각에 아래 사진을 보면서 기준을 잡아가기 시작했습니다.

![](https://miro.medium.com/max/720/1*yHX-8dJrQpH7R2hfM_21MQ.webp) <br>
[출처: [You don’t (always) need [weak self]](https://medium.com/@almalehdev/you-dont-always-need-weak-self-a778bec505ef)]

---        

## 🤔 고민한 점

> 아직 리펙토링 중이라 정리되면 추후 추가될 예정일 부분입니다.

### 아키텍처에 관한 고민
MVC와 MVVM 중 어느 아키텍처로 구현할 지 고민을 많이 했습니다. 
MVC의 단점이 뷰와 뷰컨의 결합도가 높고, 뷰컨이 방대해진다는 것이지만, 규모가 작은 프로젝트에서는 오히려 MVVM으로 구현하는 것이 오버엔지니어링이라 생각하여 MVC 패턴으로 결정했습니다.
하지만 학습의 일환으로 MVC에서 MVVM으로 추후에 리팩토링할 계획이 있습니다.


### Plan 데이터의 Create 시점
Plan 데이터의 Create 시점에 대해 고민할 때 아래의 순서도와 같은 형태를 만들어보았습니다.

![](https://i.imgur.com/Mymg7da.jpg)


저는 오른쪽의 순서도처럼 `done` 버튼을 눌렀을 때 `create` 되는 것이 더 효율적이라고 판단하였습니다.

---

## 📚 참고 링크

### 공식문서
- [Model-View-Controller](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)


### 블로그 및 기타 참조
- [iOS Architecture Patterns](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)
- [너의 MVC는 나의 MVC와 다르다](https://velog.io/@eddy_song/ios-mvc)
- [iOS design patterns — Part 1 (MVC, MVP, MVVM)](https://medium.com/swlh/ios-design-patterns-a9bd07818129)
- [iOS Swift : MVP Architecture](https://saad-eloulladi.medium.com/ios-swift-mvp-architecture-pattern-a2b0c2d310a3)
- [Using the MVVM Architectural Design Pattern in iOS
](https://blog.devgenius.io/using-the-mvvm-architectural-design-pattern-in-ios-c70e16352be5)
