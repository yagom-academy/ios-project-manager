# ⏳ 프로젝트 매니저

Gundy의 iOS Project Manager 프로젝트입니다.
**Project Manager는 계획을 만들고 관리하는 용도의 앱입니다.**

## 📖 목차

1. [팀 소개](#-팀-소개)
2. [앱 분석](#-앱-분석)
3. [Diagram](#-diagram)
4. [폴더 구조](#-폴더-구조)
5. [타임라인](#-타임라인)
6. [참고 자료](#-참고-자료)

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

## 📊 Diagram

### UML - Class Diagram

![](https://i.imgur.com/gdwvKLf.png)

## 🗂 폴더 구조

```
 ProjectManager
 ├── App
 │   ├── AppDelegate
 │   └── SceneDelegate
 ├── Resource
 │   ├── Assets
 │   └── Info.plist
 ├── Extension
 │   ├── Array+
 │   └── Date+
 ├── Model
 │   └── Plan
 ├── View
 │   └── ViewController
 └── ViewModel
     ├── ProjectConstant
     ├── ProjectListViewModel
     └── ProjectViewModel
```

## 📆 타임라인

### STEP 1

**기술스택 선정**

|화면구현|비동기처리|LocalDB|RemoteDB|의존성 관리도구|아키텍처
|:-:|:-:|:-:|:-:|:-:|:-:|
|**UIKit**|**Swift Concurrency**|**Core Data**|**Firebase**|**Swift Package Manager**|**MVVM**|

### STEP 2

**Model 생성**

- `PlanState` 열거형 생성
- `Plan` 프로토콜 생성
- `Plan`을 채택하는 `ToDo` 구조체 생성

**ViewModel 생성**

- `PlanViewModel` 프로토콜 생성
- `PlanViewModel`을 채택하는 `ProjectViewModel` 클래스 생성
- `PlanListViewModel` 프로토콜 생성
- `PlanListViewModel`을 채택하는 `ProjectListViewModel` 클래스 생성
- `ProjectConstant` 열거형 및 내부 중첩타입 `Text` 열거형 생성

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
