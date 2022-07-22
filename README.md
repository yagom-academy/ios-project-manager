# ⚒ 프로젝트 관리 앱

> 프로젝트 기간: 2022.07.04 ~ 2022.07.15 <br>
> 팀원: [마이노](https://github.com/Mino777), [두두](https://github.com/FirstDo)
> 리뷰어: [올라프](https://github.com/1Consumption)

# 📋 목차
- [프로젝트 소개](#-프로젝트-소개)
- [프로젝트 실행화면](#-프로젝트-실행화면)
- [PR](#-pr)
- [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
- [키워드](#-키워드)
- [STEP 1](#step-1)
- [STEP 2](#step-2)
- [STEP 3](#step-3)

## 🔎 프로젝트 소개
해야할 일을 TODO, DOING, DONE으로 관리하는 프로젝트 매니저입니다.

## 📺 프로젝트 실행화면
|생성|편집|이동|
|--|--|--|
|<img src="https://i.imgur.com/kkaGsEA.gif" width="400">|<img src="https://i.imgur.com/ww6Mp69.gif" width="400">|<img src="https://i.imgur.com/So8EgG1.gif" width="400">|

|히스토리 로그 기록|네트워크 연결에 따른 UI|
|--|--|
|<img src = "https://i.imgur.com/sbdTzUi.gif" width = "600">|<img src = "https://i.imgur.com/LmbQBO8.gif" width = "600">|

|앱 최초 실행시 Remote -> Local 동기화|앱 실행시 Local -> Remote 동기화|
|--|--|
|<img src = "https://i.imgur.com/xEuKj87.gif" width = "600">|<img src = "https://i.imgur.com/cGuD6Lq.gif" width = "600">|

## 👀 PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/123)
- [STEP 2](https://github.com/yagom-academy/ios-project-manager/pull/138)

## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-blue)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-yellow)]()
- [![iOS](https://img.shields.io/badge/iOS-14.4-red)]()
- [![Combine](https://img.shields.io/badge/Combine--red)]()
- [![SwiftLint](https://img.shields.io/badge/SwiftLint-0.47.1-orange)]()
- [![RealmSwift](https://img.shields.io/badge/RealmSwift-10.0-orange)]()
- [![Snapkit](https://img.shields.io/badge/Snapkit-5.6-orange)]()
- [![FirebaseDatabase](https://img.shields.io/badge/FirebaseDatabase-9.3-orange)]()

## 🔑 키워드
- `iPad`
- `DIContainer`
- `Dependency Injection`
- `Clean Architecture`
- `MVVM`
- `Coordinator`
- `Reactive Programming`
- `Combine`
- `ARC`
- `Parent, Child ViewModel`
- `Test Double`
- `상태 검증 테스트`
- `행위 검증 테스트`
- `Snapkit`
- `Realm`
- `Firebase RealtimeDB`

---

## [STEP 1]

## App 구조

### DIContainer, Coordinator
<img src="https://i.imgur.com/fiGtIdn.png" width="400">

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/rAVuZ8Y.png" width="600">

#### 선택한 이유
- 기존 MVVM의 경우 MVC보다는 계층이 분리되고, 객체들의 관심사가 분리되지만 그럼에도 ViewModel의 역할이 커지는 문제가 발생
- CleanArchitecture를 통해 Layer를 한층 더 나누어 주면서 계층별로 관심사가 나누어지게 되고, 자연스럽게 각각의 객체들의 역할이 분명하게 나누어짐
- 이로 인해 객체들의 결합도가 낮아지고, 응집도는 높아지면서 문제가 발생했을 때 쉽게 찾을 수 있고 해당 부분만 수정이 가능해지면서 유지보수적인 측면에서 상당한 이점을 갖을 수 있음
- DIContainer를 통한 의존성 주입으로 ViewModel, UseCase, Repository, Storage에 대한 테스트가 용이해짐

### Layer

#### Presentation Layer
- UI를 포함하는 계층으로 View와 ViewModel을 포함

#### Domain Layer
- 비즈니스 로직을 포함하는 계층으로 Entity, UseCase, Repository Interface를 포함.

#### Data Layer
- Data Source를 포함하는 계층으로 Repository와 API, DB등을 포함

#### DIContainer

의존성 주입을 책임짐

#### Coordinator

화면전환을 책임짐

#### Data Flow
![](https://i.imgur.com/KNPgzYL.png)

#### 참고링크
- [Medium: Clean Architecture and MVVM on iOS](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)
- [GitHub: iOS-Clean-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)
- [Clean Code](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## Local DB
||장점|단점|
|:---:|:---:|:---:|
|CoreData|firstParty, 저장된 기록을 SQLite보다 빠르게 가져온다|SQLite 보다 더 많은 메모리를 사용하고,더 많은 저장공간이 필요하다. iOS환경에서만 사용가능 |
|Realm|빠르고, CoreData보다 훨씬 간단하게 사용가능, 크로스 플랫폼 지원|thirdParty 라이브러리리|

- https://cocoacasts.com/core-data-or-realm
- https://realm.io/best-ios-database/#faq

> Realm is a fast, reactive, and scalable alternative to SQLite that makes storing, syncing, and querying data simple for modern mobile applications.
>
> Realm is an open source, fast, scalable alternative to CoreData and SQLite that makes storing, syncing, and querying data simple for modern iOS applications.

## Remote DB

FireBase 문서에서 RealTime DB와 Cloud Firestore을 선택하는 기준이 있어서 확인해봤습니다.
이번 프로젝트는 다음과 같습니다
- 고급 쿼리, 정렬, 트랜잭션이 필요하지 않습니다
- 소규모 업데이트 스트림을 보냅니다 
- 간단한 JSON 데이터를 저장합니다

그래서 `RealTime DB`를 선택하기로 결정했습니다

## SnapKit

- AutoLayout을 설정할때, 기존에는 작성해야하는 코드양이 꽤 많았는데, SnapKit을 사용하면 Constraints들을 한번에 묶어서 설정할 수 있어서 코드양을 줄일수 있음

## 적용기술 선정 및 근거

### 적용 기술 선정

|LocalDB|RemoteDB|비동기이벤트처리|Layout|Convention|의존성관리도구|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Realm|RealTimeDB|Combine|SnapKit|SwiftLint|CocoaPod|

### 적용기술 선정 근거

#### 1. 하위 버전 호환성에는 문제가 없는가?

- Firebase: iOS 10 이상
- Realm: iOS 8 이상
- Combine: iOS 13 이상

지난 4년 동안 도입된 기기의 89%가 iOS 15를 사용하고 있음
프로젝트의 타겟을 iOS14 이상으로 설정할 것이므로 문제가 없음

#### 2. 안정적으로 운용 가능한가?

- Firebase: 구글에서 운영, 대중적이기에 레퍼런스가 많음
- Realm: 작업 속도가 빠르고, Realm Studio(GUI) 등의 편의성, MongoDB가 운영
- Combine: 애플이 공식지원하는 라이브러리

#### 3. 미래 지속가능성이 있는가?

- Firebase: 구글이 지원
- Realm: 최근 MongoDB가 인수하면서 지속가능성이 늘어남
- Combine: 애플이 공식지원하고, 앞으로 많이 쓰일일만 남음

#### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

- Firebase: 프로젝트가 커졌을 경우 프로젝트관리 / 과금 정책등 불편할 수 있음
- Realm: 사용해보지 않았기 때문에 학습을 해야함 / 추후 유료화가 진행될 수 있다
- Combine: 없음

#### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?

사용하는 모든 라이브러리가 CocoaPods을 지원함
SwiftLint가 SPM를 지원하지 않기때문에 무조건 `CocoaPods`을 써야함

## [STEP 2]

### 인스턴스의 RC관리

최상위 AppDIContainer에서 모든 의존성(현재는 Storage)을 관리하고, 하위에 주입해주는 방법을 사용했다
클래스를 전달하다보니, 전달할때마다 RC가 늘어나는 문제가 있었다
외부에서 주입받은 의존성의 경우 unowned를 붙여서 불필요한 RC를 늘리지 않고 의존성을 주입해주었다

### ViewModel 간의 통신

하나의 ViewController에서 View가 여러개 있을때 ViewModel 또한 여러개 있을 수 있다
이때 하위 viewModel에서 일어나는 일을 상위 viewModel에 이벤트만 전달하여 상위 viewModel에서 비즈니스 로직/ 화면전환 등을 처리하게 해야했다
ViewModel간에 delegate를 설정해서 하위 viewModel은 상위 viewModel에게 이벤트를 전달하도록 구현하였다

### ViewModel Test

ViewModel은 UseCase가 필요하다
UseCae는 Repository가 필요하다
Repository는 Storage가 필요하다

그리고 UseCase, Repository, Storage는 모두 프로토콜로 추상화되어 있다.
Fake Storage -> Fake Repository -> Fake UseCase를 만들어서 ViewModel에 주입한 후
ViewModel의 Input, Output을 테스트하였다

### Mock과 Stub의 차이

테스트를 위해 객체를 만들때 TestDouble이라는 이름으로 만들게 된다

#### Mock은 행위검증

이 행동이 일어났는가? (즉 이 매서드가 호출되었는가) 를 검증

#### Stub은 상태검증
Stub의 경우에는 이미 반환해야될 결과값이 정해져 있다
예를들어 네트워크 없이 네트워크를 테스트를 할때 정해진 response를 반환하는 MockURLSession을 

현재 테스트를 위해 만드는 Storage, UseCase, Repository는 실제 객체와 동일하게 동작하도록 만들었기 때문에 Fake로 만들었음

### @Published, CurrentValueSubject, PassthroughSubject의 차이

CurrentValueSubject는 초기값이 있고, 가장 최근 값에 대한 버퍼를 유지
그래서 새로운 subscriber가 구독했을때 무조건 가장 최근 값을 방출

반면에 PassthroughSubject는 초기값이 없고, 가장 최근 값에 대한 버퍼를 유지하지 않음
새로운 subscriber가 해당 subject를 구독했다면, 그 이전의 이벤트는 전달되지 않음
오직 구독 후에 발생하는 이벤트만 subscriber에게 전달 됨

@Published와 CurrentValueSubject는 비슷하다고 생각
다만 @Published property wrapper는 프로퍼티에 해당property wrapper를 붙이면 publisher처럼 쓸 수 있게 지원

- class에만 쓸 수 있음
- 에러를 방출하지 않는다 (Never 타입)

## [STEP 3]

### Realm, FireBase RealTime DB 적용

LocalDB: Realm
RemoteDB: FireBase

적절한 시점에 두 db를 동기화

### 테스트 코드 작성

View를 제외한 모든부분에 테스트를 작성
`ViewModel`을 테스트하기 위해서 `StubUseCase`를 작성하여 테스트

`UseCase`를 테스트하기 위해서 `MockRepository`를 작성하여 UseCase가 Repository의 매서드를 정상적으로 호출하는지 `행위검증`

`Repository`를 테스트하기 위해서 `MockStorage`를 작성하여 Repository가 Storage의 매서드를 정상적으로 호출하는지 행위검증

### 오류처리

Realm과 FireBase는 그 특성상 CRUD작업시 오류가 생길 수 있음
이때 발생한 오류는 VC에서 alert으로 처리하고자 하였다

#### Storage, Repository, UseCase

오류가 발생할 수 있는 매서드는 `AnyCancellable<Void, StorageError>` 를 반환
Combine에는 rx의 `Completable`이 없기에, `Empty`와 `Fail`을 같이 사용
비동기 이벤트의 경우 `Future`를 활용

#### ViewModel

ViewModel에서 모든 오류를 `var showErrorAlert: CurrentValueSubject<String, Never>`에 send

#### VC

VC에서 ViewModel.showErrorAlert을 구독하여, 이벤트가 발생할때마다 alert을 띄우도록 구현
