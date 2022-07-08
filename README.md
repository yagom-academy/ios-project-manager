# 💻 프로젝트 매니저
> 프로젝트 기간 2022-07-04 ~ 2022-07-15  

- [소개](#소개)
- [팀원](#팀원)
- [리뷰어](#리뷰어)
- [타임라인](#타임라인)
- [실행화면](#실행-화면)
- [UML](#uml)
- [트러블 슈팅](#트러블-슈팅)
    - [1️⃣ subscribe vs bind vs drive](#1%EF%B8%8F%E2%83%A3-subscribe-vs-bind-vs-drive)
    - [2️⃣ observable vs subject](#2%EF%B8%8F%E2%83%A3-observable-vs-subject)
    - [3️⃣ clean architecture](#3%EF%B8%8F%E2%83%A3-clean-architecture)
    - [4️⃣ DB 선정](#4%EF%B8%8F%E2%83%A3-db-%EC%84%A0%EC%A0%95)
    - [5️⃣ UI](#5%EF%B8%8F%E2%83%A3-ui)
    - [6️⃣ Mock Data Layer](#6%EF%B8%8F%E2%83%A3-mock-data-layer)

## 소개
프로젝트를 진행 상황을 todo list형태로 정리하고, 계획하는 아이패드 앱

## 팀원
|[mmim](https://github.com/JoSH0318)|[Tiana](https://github.com/Kim-TaeHyun-A) |
|:---:|:---:|
|<img src="https://i.imgur.com/GUrxJqu.jpg" height="240">|<img src="https://i.imgur.com/BSxMgfj.png" width="240"> |

## 리뷰어
[내일날씨맑음](https://github.com/SungPyo)


## 타임라인
|일시|내용 |
|:---:|:---:|
|2022.07.04(월)|프로젝트 기술 스택 선정 및 기획 수립|
|2022.07.05(화)|프로젝트 진행(UI 구현)|
|2022.07.06(수)|프로젝트 진행(Main, Detail 화면 기능 구현)|
|2022.07.07(목)|프로젝트 진행(설계 구조 변경으로 인한 리팩토링)|
|2022.07.08(금)|프로젝트 진행(RxDataSource 적용 및 부가 기능 구현)|

## UML

## 실행 화면

## 트러블 슈팅
### 1️⃣ subscribe vs bind vs drive
- UI에 데이터를 나타내줄 때 BehaviorRelay를 사용하여 Observer를 연결해주는 방법을 선택했다.
- 이 때, subscribe / bind / drive 중 어떤 Observer를 선택할 것인지에 대해 고민했고, 이 것들의 차이를 알아야했다.
- 아래의 예시 코드처럼 같은 기능을 각각 subscribe과 drive로 구현할 수 있다. 어떠한 차이점이 있는지, 어떠한 옵저버를 사용할 지에 대해 고민했다.
![](https://i.imgur.com/9gYep0D.png)

### subscribe
- 구독 연산자를 통해 observable끼리 연결 가능하다. 
- observable이 observable에게 내보내는 item을 보거나 옵저버블에서 오류 또는 완료된 알림을 수신하려면 이 연산자로 해당 옵저버블을 구독해야 한다.
- `onNext` : observable이 item을 방출할 때 호출되는 메서드
- `onError` : 기대하는 타입이 맞지 않거나 에러가 발생할 때 호출되는 메서드로서 observable을 종료시키고 더이상 `onNext` / `onCompleted` 이 호출 되지 않는다.
- `onCompleted` : observable이 마지막으로 `onNext`를 호출하면 호출되는 메서드이며, 어떤 에러도 발생시키지 않는다.
```swift
public func subscribe(
    onNext: ((Element) -> Void)? = nil,
    onError: ((Swift.Error) -> Void)? = nil,
    onCompleted: (() -> Void)? = nil,
    onDisposed: (() -> Void)? = nil
) -> Disposable {
        let disposable: Disposable
        
        if let disposed = onDisposed {
            disposable = Disposables.create(with: disposed)
        }
        else {
            disposable = Disposables.create()
        }
        
        let callStack = Hooks.recordCallStackOnError ? Hooks.customCaptureSubscriptionCallstack() : []
        
        let observer = AnonymousObserver<Element> { event in
            switch event {
            case .next(let value):
                onNext?(value)
            case .error(let error):
                if let onError = onError {
                    onError(error)
                }
                else {
                    Hooks.defaultErrorHandler(callStack, error)
                }
                disposable.dispose()
            case .completed:
                onCompleted?()
                disposable.dispose()
            }
        }
        return Disposables.create(
            self.asObservable().subscribe(observer),
            disposable
        )
}

```

### bind
- bind 메서드 내부에는 subscribe가 호출되고 있고, error에 대한 처리를 해주고 있다. 만약 bind를 사용한다면 에러에 대한 처리를 하지 않아도 된다.
- 이러한 특징 때문에 UI에 관련된 로직에서 많이 사용되는 것으로 생각할 수 있다.
- 하지만 메인 스레드에서 처리하지 않기 때문에 별도의 스레드 관리가 필요하다.
```swift
public func bind(onNext: @escaping (Element) -> Void) -> Disposable {
    self.subscribe(onNext: onNext,
                   onError: { error in
                    rxFatalErrorInDebug("Binding error: \(error)")
                   })
}
```

### drive
- 메인 스레드에서 돌아가도록 내부 구현이 되어 있으므로 UI 구현 시 많이 사용된다.
```swift
public func drive<R1, R2>(
    _ with: (Observable<Element>) -> (R1) -> R2,
    curriedArgument: R1
) -> R2 {
    MainScheduler.ensureRunningOnMainThread(errorMessage: errorMessage)
    return with(self.asObservable())(curriedArgument)
}
```
- 위 메서드는 observable을 만들고 구독하지 않는다. 따라서, 변경사항에 동적으로 대응하지 못한다. 또한 커링으로 메서드가 바로 실행되어 이번 프로젝트에 적절하지 않다.

```swift
public func drive(
    onNext: ((Element) -> Void)? = nil,
    onCompleted: (() -> Void)? = nil,
    onDisposed: (() -> Void)? = nil
) -> Disposable {
    MainScheduler.ensureRunningOnMainThread(errorMessage: errorMessage)
    return self.asObservable().subscribe(onNext: onNext, onCompleted: onCompleted, onDisposed: onDisposed)
}
```
- 반면, 위 메서드는 내부에서 구독하고 disposable을 반환해서 동적 반응 가능하다.


### 2️⃣ observable vs subject
### observable
[observable 링크](https://reactivex.io/documentation/observable.html)
시간 흐름에 따른 데이터 변화를 인지하고 반응할 수 있다.
![](https://i.imgur.com/KFjI1Cu.png)


### subject
[subject 링크](https://reactivex.io/documentation/subject.html)
observable을 구독하는 observable이다.

[참고 자료](https://github.com/ReactiveX/RxSwift)
```
┌──────────────┐    ┌──────────────┐
│   RxCocoa    ├────▶   RxRelay    │
└───────┬──────┘    └──────┬───────┘
        │                  │        
┌───────▼──────────────────▼───────┐
│             RxSwift              │
└───────▲──────────────────▲───────┘
        │                  │        
┌───────┴──────┐    ┌──────┴───────┐
│    RxTest    │    │  RxBlocking  │
└──────────────┘    └──────────────┘
```
- [RxRelay](https://github.com/JakeWharton/RxRelay)
    - `error` / `completed` 로 종료되지 않아서 UI 구현 시 많이 사용된다.
    - BehaviorRelay : 가장 최신 이벤트와 이후 이벤트를 방출한다.
    - PublishRelay : 구독한 이후의 값만 방출한다.
    - ReplayRelay : 버퍼에 있는 이벤트를 방출한다.
- [BehaviorRelay](https://github.com/ReactiveX/RxSwift/blob/main/RxRelay/BehaviorRelay.swift)
    - 초기 값을 부여해서 인스턴스를 생성한다.
```swift
public final class BehaviorRelay<Element>: ObservableType {
    private let subject: BehaviorSubject<Element>
    public func accept(_ event: Element) {
        self.subject.onNext(event)
    }
    public var value: Element {
        return try! self.subject.value()
    }
    public init(value: Element) {
        self.subject = BehaviorSubject(value: value)
    }
    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
        self.subject.subscribe(observer)
    }
    public func asObservable() -> Observable<Element> {
        self.subject.asObservable()
    }    
}
```

### 3️⃣ clean architecture
- 프로젝트의 STEP1, 2는 local/remote DB를 사용하지 않는다. 이후에 프로젝트가 진행됨에 따라 local/remote DB 기능을 추가할 것으로 판단했고, 프로젝트의 기능 확장성을 고려한 설계구조를 고민했다.
- 만약 clean architecture를 사용한다면 STEP1, 2는 Presentation, Domain Layer을 구현하고, 이후 STEP에서는 Data Layer를 구현하여 추가하면 편리할 것으로 예상했다.
- 이러한 근거로 clean architecture를 설계 구조로 선택했다.

<img src="https://miro.medium.com/max/1400/1*JxCAYFc2UsovUdt13vtEwQ.png" height="300"/>

<img
src="https://miro.medium.com/max/1400/1*MzkbfQsYb0wTBFeqplRoKg.png" height="150"/>

<img
src="https://miro.medium.com/max/1400/1*N3ypUNMUGv87qUL57JyqJA.png" height="150"/>

[참고문헌: Clean Architecture and MVVM on iOS](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)

### 4️⃣ DB 선정

#### CoreData
* 테이블 지향 관계형 데이터베이스(Relational database)이다.
* in-memory 라서 로딩된 데이터 수정만 가능하다.
* iCloud를 활용할 수 있다.
* 독립적으로 작성되어 재사용 및 유지보수가 편리하다.
* thread-safe 하지 않는다.

#### Firebase
* RTSP(Real Time Stream Protocol) 방식으로 실시간으로 데이터들을 전송 시 사용된다.
* 관리자 페이지와 앱 사용 통계 정보 제공한다.
* 서버가 해외에 있을 때 종종 처리 속도 느리다.
* 데이터 검색이 어려워서 앱에서 모든 데이터 받아서 필터링 필요

### 5️⃣ UI
- 이번 프로젝트는 총 3가지 화면이 있다고 판단했다.
    1. Main화면: todo, doing, done table이 있는 root view
    2. 상세화면: cell 클릭하면 이동되는 화면
    3. 추가화면: navigationItem을 클릭하면 이동되는 화면

#### Main화면 UI
![](https://i.imgur.com/1BKM2R6.jpg)
- 이 프로젝트의 상세화면, 추가화면은 앱의 흐름상 크게 벗어나는 화면이 아니다.
- 따라서 Navigation을 이용한 화면이동을 생각했고, navigationBar를 사용했다.
- 동일한 크기의 TableView 3개가 있어야하기에 horizontal stackView를 사용하여 3개의 TableView를 구현했다.
- tableView의 프로퍼티인 header는 section 별로 존재한다. 따라서 만약 한 table에 2개 이상의 section이 존재한다면 header도 2개 이상이다. header는 한개 존재해야기 때문에 별도의 HeaderView객체를 사용했다.
- vertical stackView에 Header와 TableView를 넣어주는 방법으로 구현했다.

#### 상세화면 / 추가화면 UI 
![](https://i.imgur.com/gadn0LL.jpg)
- 상세화면, 추가화면은 UI요소가 같다. 따라서 같은 View를 공유하도록 설계했다.

### 6️⃣ Mock Data Layer
- STEP1, 2는 DB을 사용하지 않기 때문에 ViewModel간 데이터 이동을 통해 CRUD 기능을 구현해야한다. 때문에 객체간의 결합도가 올라간다.
- 결합도가 높아진 문제는 기능 확장성을 낮추는 결과를 초래한다. 따라서 MockStorage를 만들어 앱을 사용하는 동안 데이터를 저장하도록, CURD 기능을 만들어주었다.
- 이러한 결과로 이후 Local/Remote DB 기능을 추가할 때, 앱의 확장성이 높아질 것으로 예상한다.

```swift
final class MockStorageManager {
    static let shared = MockStorageManager()
    private init() {}
    
    private var projects: [ProjectContent] = []
    var projectEntity = BehaviorRelay<[ProjectContent]>(value: [])
    
    func create() {}
    func read() -> [ProjectContent] {}
    func update() {}
    func delete() {}
}
```
