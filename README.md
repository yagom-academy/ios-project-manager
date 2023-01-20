# ⏳ 프로젝트 매니저

Gundy의 iOS Project Manager 프로젝트입니다.
**Project Manager는 계획을 만들고 관리하는 용도의 앱입니다.**

## 📖 목차

1. [팀 소개](#-팀-소개)
2. [앱 분석](#-앱-분석)
3. [Diagram](#-diagram)
4. [폴더 구조](#-폴더-구조)
5. [타임라인](#-타임라인)
6. [실행 화면](#-실행-화면)
7. [트러블 슈팅 및 고민한 부분](#-트러블-슈팅-및-고민한-부분)
8. [참고 자료](#-참고-자료)

## 🌱 팀 소개

|[Gundy](https://github.com/Gundy93)|
|:-:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src= "https://avatars.githubusercontent.com/u/106914201?v=4">|
|**중요한 것은 꺾이지 않는 마음**, 그런데 살짝 꺾였을지도?(농담)|

## 📲 앱 분석

### 앱의 목표

**할 일(계획)** 을 **관리(생성, 상태변경)** 한다.

<details>
<summary> 
역할 펼쳐보기
</summary>
    
![](https://i.imgur.com/swRAYE2.png)

### Model

- 계획
    - 제목
    - 설명
    - 기한
    - 상태
- 상태
    - to do
    - doing
    - done

### ViewModel: 값이 변하면 뷰 또한 변한다.

- 전체 화면에 대응하는 뷰모델
    - 상태별 계획의 배열
    - 계획의 생성
    - 계획의 수정
    - 계획의 상태 변경
        - to do -> doing, done
        - doing -> to do, done
        - done -> to do, doing
    - 계획 삭제
- 상세 화면 및 셀에 대응하는 뷰모델
    - 계획
    - 기한 포맷팅
    - 기한 유효성
    - 수정 가능 여부
- 상수
    - 네비게이션 타이틀
    - 헤더 타이틀
    - 플레이스 홀더
    - 바버튼 타이틀
    - 팝오버 버튼 타이틀

### View: 입력을 뷰모델에 전달한다.

- 전체 화면
    - 네비게이션 바
        - `+` 버튼을 통해 새로운 계획 생성 화면을 띄운다.
            - `cancel` 버튼을 누르면 추가하지 않고 취소한다.
            - `done` 버튼을 누르면 뷰모델에 새로운 계획 생성을 요청한다.
    - to do, doing, done의 세 리스트
        - 각 리스트는 계획의 수를 레이블로 표시
            - 뷰모델에 count 요청
        - 계획의 수만큼의 셀을 갖는다.
        - 셀을 누르면 상세 화면을 모달로 띄운다.
        - 셀을 꾹 누르면 팝오버를 띄운다.
            - 팝오버의 버튼을 통해 계획의 위치를 이동시킨다.
                - 뷰모델에 상태변화를 요청한다.
        - 스와이프 기능을 갖는다.
            - 왼쪽으로 밀면 삭제 버튼이 나온다.
            - 삭제 버튼을 누르거나 왼쪽 끝까지 밀면 셀을 삭제한다.
                - 뷰모델에 계획 삭제 요청을 한다.
- 셀
    - 리스트의 셀은 계획의 제목, 설명, 기한의 레이블을 갖는다.
        - 제목은 한 줄이고, 길면 생략한다.
            - text는 뷰모델에 요청한다.
        - 설명은 최대 세 줄이고, 길면 생략하며, 설명 글의 높이에 따라 셀의 높이가 변한다.
            - text는 뷰모델에 요청한다.
        - 기한이 경과했을 경우 빨간 색으로 표시한다.
            - text, 기한 경과 여부는 뷰모델에 요청한다.
- 계획 화면
    - 상세/추가 화면은 제목을 표시하는 텍스트 필드, 기한을 표시하는 데이트 피커, 설명을 표시하는 텍스트 뷰로 구성한다.
        - 상세 화면의 경우 `Edit` 버튼을 누르면 작성이 가능해진다.
            - 작성이 가능한지 여부를 뷰모델에 묻는다.
        - 제목 텍스트 필드는 플레이스 홀더를 갖는다.
            - 이 플레이스 홀더에 들어갈 값은 네임 스페이스에서 가져온다.
        - 텍스트 필드와 텍스트 뷰는 그림자를 보여준다.
    
</details><br>

### 클린 아키텍쳐 레이어 구분

<details>
<summary> 
레이어 펼쳐보기
</summary>

![](https://i.imgur.com/Kq55dgL.png)

### Entity

계획 그 자체와 관련된 코드, 즉 모델이 위치할 것입니다.

- 프로젝트
- 프로젝트의 상태

### Use Cases

계획을 직접적으로 관리하는 코드(도메인 로직)가 위치할 것입니다.

- 계획 관리
    - 계획의 생성
    - 계획의 수정
    - 계획의 상태변경
    - 계획의 삭제

### Interface Adapters

Controllers, Gateways, Presenters 등이 속하는 계층이므로 ViewController, ViewModel, 각종 DBManager의 코드가 위치할 것입니다.

- ViewModel
    - 뷰에 보여주기 적절하게끔 계획을 포맷팅
    - 뷰에 값을 전달
- ViewController
    - 사용자의 상호작용에 따라 제어의 흐름을 Use Cases에 전달
        - Use Cases 내부에서 도메인 로직이 실행된 이후 ViewModel에 전달,
        - 전달 받은 ViewModel은 해당 데이터를 가공해서 View에 전달
- 각종 Mananger
    - 내부의 값을 DB에 맞게 변경하는 등의 로직
    - 그 외에도 다양한 Manager 객체들

### Frameworks and Drivers

DB, 프레임워크, UI 같은 것들이 위치할 것입니다.

- Local DB
    - CoreData
- Remote DB
    - Firebase
- UI
    - View(CustomComponent)
    
</details><br>

#### List 화면 관련 레이어 구분
![](https://i.imgur.com/y2ZVQpC.png)<br>

#### Detail 화면 관련 레이어 구분
![](https://i.imgur.com/rV9FDXr.png)

## 📊 Diagram

### UML

![](https://i.imgur.com/2Lu0YWR.png)

## 🗂 폴더 구조

```
 ProjectManager
├── AppDelegate
├── SceneDelegate
├── Resource
│   ├── Assets
│   ├── Info.plist
│   └── Storyboard
├── Util
│  ├── Constant
│  │   └── Constant
│  └── Extension
│      ├── CGFloat+
│      ├── Date+
│      └── UITableView+
├── Domain
│   ├── Model
│   │   ├── Project
│   │   ├── ProjectTextItem
│   │   └── State
│   └── UseCase
│       ├── Detail
│       │   ├── Protocol
│       │   │   ├── DetailProject
│       │   │   └── DetailUseCase
│       │   └── DefaultDetailUseCase
│       └── List
│           ├── Protocol
│           │   ├── ListOutput
│           │   └── ListUseCase
│           └── DefaultListUseCase
└──Presentation
    ├── Detail
    │   ├── View
    │   │   ├── DetailTextField
    │   │   └── DetailTextView
    │   ├── ViewController
    │   │   └── DetailViewController
    │   └── ViewModel
    │       └── DetailViewModel
    └── List
        ├── View
        │   ├── CircleLabel
        │   ├── ListCell
        │   ├── ListHeaderView
        │   ├── ListView
        │   └── Reusable
        ├── ViewController
        │   └── ListViewController
        └── ViewModel
            └── ListViewModel

```

## 📆 타임라인

### STEP 1

**기술스택 선정**

|화면구현|비동기처리|LocalDB|RemoteDB|의존성 관리도구|아키텍처
|:-:|:-:|:-:|:-:|:-:|:-:|
|**UIKit**|**Swift Concurrency**|**Core Data**|**Firebase**|**Swift Package Manager**|**MVVM**|

### STEP 2

> 작성예정

## 📱 실행 화면
|![](https://i.imgur.com/PfW3TH5.gif)|![](https://i.imgur.com/VQTgsxw.gif)|
|:-:|:-:|
|**프로젝트 생성 기능**|**프로젝트 편집 기능**|<br>

|![](https://i.imgur.com/HovnSrk.gif)|![](https://i.imgur.com/BaItXdg.gif)|
|:-:|:-:|
|**프로젝트 이동 기능**|**프로젝트 삭제 기능**|<br>

|![](https://i.imgur.com/mtaCqZt.gif)|![](https://i.imgur.com/TgFGdAo.gif)|
|:-:|:-:|
|**글자수 제한 기능**|**기한 제한 기능**|<br>

## 🎳 트러블 슈팅 및 고민한 부분

### MVVM 역할 구분

![](https://i.imgur.com/swRAYE2.png)

- Model
    - 데이터와 관련된 코드
        - 앱 내부(Domain)로의 모델과 외부(DB, Web)로의 모델로 구분될 것이다.
- View
    - UI와 관련된 코드
        - 직접적으로 컴포넌트를 그리는 뷰와 이를 컨트롤하는 뷰컨트롤러가 포함될 것이다.
- ViewModel
    - 뷰에서 그려질 값을 제공하는 코드
        - MVVM뿐이라면 모델의 포맷을 뷰에 제공하기 알맞게 변경하는 로직또한 이 계층에 포함될 것이다.
- 그렇다면 위 세 경우에 해당하지 않는 부분은?
    - 서비스 로직에 해당하는 코드
        - 데이터베이스에 연결하고, 서버와 통신하는 등의 도메인 로직과 깊은 관련이 없는 코드
        - 이 코드들은 M, V, VM 중 어디에 위치해야 하는가?

![](https://i.imgur.com/v3Q6N6Z.png)

MVVM의 역할 구분에 대해 생각해보니 이런 그림을 그려볼 수 있었습니다. 어쩌면 MVC, MVP, MVVM 모두 사실은 이런 부분들이 생략되어 있었고, 해당 로직이 집중하는 가운데 부분(C, P, VM)이 비대해지는 것은 너무 당연한 것이 아닐까 하는 생각도 들었습니다. 세 개의 역할군만으로는 앱의 모든 코드를 규정할 수 없는 것 같았습니다. 그렇다보니 최소 4개의 레이어로 구분되는 클린 아키텍쳐의 경우가 계층의 관심사 분리가 더욱 명확해진다고 생각했습니다. 그렇기 때문에 클린 아미텍쳐의 적용을 경험해보는 것이 좋은 경험이 되리라고 확신하게 되었습니다.

## 📚 참고 자료

### Human Interface Guidelines

- [**Lists and tables**](https://developer.apple.com/design/human-interface-guidelines/components/layout-and-organization/lists-and-tables)
- [**Popovers**](https://developer.apple.com/design/human-interface-guidelines/components/presentation/popovers/)
- [**Pickers**](https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/pickers/)
- [**Notifications**](https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/notifications)

### Apple Developer Documentation

- [**DateFormatter**](https://developer.apple.com/documentation/foundation/dateformatter)
- [**User Notifications**](https://developer.apple.com/documentation/usernotifications/)
- [**Scheduling a Notification Locally from Your App**](https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app)
- [**Handling Notifications and Notification-Related Actions**](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)

### Apple Developer Discover

[**Get started with Swift concurrency**](https://developer.apple.com/news/?id=o140tv24)

### Apple Developer Videos

[**WWDC21 - Meet async/await in Swift**](https://developer.apple.com/videos/play/wwdc2021/10132/)

### THE SWIFT PROGRAMMING LANGUAGE

[**Concurrency**](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)

---

[⬆️ 맨 위로 이동하기](#-프로젝트-매니저)
