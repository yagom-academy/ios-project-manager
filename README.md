# 🗂️ 프로젝트 매니저
> 사용자의 일정을 표시하는 iPad 앱입니다.
> * 주요 개념: `MVVM`, `Combine`
> 
> 프로젝트 기간: 2023.05.15 ~ 2023.06.02

### 💻 개발환경 및 라이브러리
<img src = "https://img.shields.io/badge/swift-5.8-orange"> <img src = "https://img.shields.io/badge/Minimum%20Diployment%20Target-13.0-blue"> <img src = "https://img.shields.io/badge/CocoaPods-1.11.3-brightgreen"> 

<img src = "https://img.shields.io/badge/Firebase-10.9.0-red">

## ⭐️ 팀원
| Rowan | Brody |
| :--------: |  :--------: |
| <Img src = "https://i.imgur.com/S1hlffJ.jpg"  height="200"/> |<img height="200" src="https://avatars.githubusercontent.com/u/70146658?v=4" width="200">|<img src="https://github.com/Andrew-0411/ios-diary/assets/45560895/2872b119-d22b-46a7-85c4-d9e0c3dd6da8">
| [Github Profile](https://github.com/Kyeongjun2) |[Github Profile](https://github.com/seunghyunCheon) | 

</br>

## 📝 목차

1. [타임라인](#-타임라인)
2. [프로젝트 구조](#-프로젝트-구조)
3. [실행화면](#-실행화면)
4. [트러블 슈팅](#-트러블-슈팅)
5. [핵심경험](#-핵심경험)
6. [참고 링크](#-참고-링크)

</br>

# 📆 타임라인

- 2023.05.15: 기술스택, 저장소 선택.
- 2023.05.16: MVVM 아키텍처 학습.
- 2023.05.17: 메인화면, TodoListViewModel, TodoViewModel 구성.
- 2023.05.18: Combine개념 학습.
- 2023.05.19: 할 일 추가화면 플로우차트, UML, README 작성.
- 2023.05.22: Detail화면 구현 및 Combine적용.
- 2023.05.23: Task추가 시 메인화면에 적용.
- 2023.05.24: 메인 화면 내의 하나의 컬렉션뷰에서 3개의 컬렉션 뷰 사용하도록 변경.
- 2023.05.25: CollectionViewModel 추상화하여 보일러 플레이트 코드 삭제.
- 2023.05.26: 뷰모델에서 뷰를 제외한 UML 재설계, README 작성.
- 2023.05.29: 뷰 - 뷰모델 바인딩 리팩토링, popOverStyle modal view 정의
- 2023.05.30: 객체 간 의존성 주입 구현, 시뮬레이터 작동 시 발생한 오류 수정
- 2023.05.31: 요구사항에 맞는 UI 구현, 스트림에서 오류를 던질 수 있도록 리팩토링 
- 2023.06.01: 객체 관계 재설계 및 UML 수정 및 리팩토링, 컬렉션뷰 스냅샷 리로드 기능 개선
- 2023.06.02: ViewModel 내부 이벤트 바인딩을 위한 Input / Output Nested Type 추가, MainViewModel 리팩토링 및 README 작성

</br>

# 🌳 프로젝트 구조

## UML Class Diagram
![](https://hackmd.io/_uploads/BkUD2NvLn.jpg)
![](https://hackmd.io/_uploads/rkvX34PI3.jpg)
![](https://hackmd.io/_uploads/BJFSpXDI3.jpg)

</br>

## File Tree
```swift
└── Diary
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    ├── Model
    │   ├── Plan.swift
    │   ├── WorkState.swift
    │   └── Service
    │       └── PlanStorageService.swift
    ├── MainView
    │   ├── MainViewController.swift
    │   ├── MainViewModel.swift
    │   ├── PlanCollectionView
    │   │   ├── PlanCollectionViewController.swift
    │   │   ├── TodoViewModel.swift
    │   │   ├── DoingViewModel.swift
    │   │   ├── DoneViewModel.swift
    │   │   └── PlanListViewModel.swift
    │   ├── PlanCell
    │   │   ├── PlanCell.swift
    │   │   └── PlanCellViewModel.swift
    │   └── HeaderView
    │       ├── HeaderView.swift
    │       └── HeaderViewModel.swift
    ├── DetailView
    │   ├── DetailViewController.swift
    │   └── DetailViewModel.swift
    ├── Protocols
    │   └── ReuseableIdentifier.swift
    ├── Extensions
    │   ├── Combine
    │   │   ├── UIControl+Combine.swift
    │   │   ├── UITextView+Combine.swift
    │   │   ├── UITextField+Combine.swift
    │   │   └── UIDatePicker+Combine.swift
    │   ├── Array.swift  
    │   └── CALayer.swift
    ├── Assets
    ├── LaunchScreen
    ├── Info.plist
    └── GoogleService-Info.plist
```

</br>

# 📱 실행화면

|할 일 추가|할 일 수정|
|:--:|:--:|
|<img src="https://github.com/seunghyunCheon/Diary/assets/70146658/c186b2c4-ef79-4806-8e4b-2f5c1bef4644" width="700">|<img src="https://github.com/seunghyunCheon/Diary/assets/70146658/b95556ae-4a13-4fa4-9a50-5012de76c84c" width="700">|

|할 일 삭제|할 일 이동|
|:--:|:--:|
|<img src="https://github.com/seunghyunCheon/Diary/assets/70146658/4720d776-3fdb-44a3-8756-95eae80eee44" width="700">|<img src="https://github.com/seunghyunCheon/Diary/assets/70146658/1bd44cd4-1a2c-4660-bbb0-4ba5c98dc440" width="700">|

|기한지난 할 일|확인 버튼 활성화|
|:--:|:--:|
|<img src="https://github.com/seunghyunCheon/Diary/assets/70146658/645b2a79-1b05-4fd9-b707-fa6d5396b0e0" width="700"/>|<img src="https://github.com/seunghyunCheon/Diary/assets/70146658/64a465e1-95f4-4307-9d01-ced02aa163f9" width="700"/>|






</br>

# 🚀 트러블 슈팅

## 1️⃣ MVVM 아키텍처 설계

### 🔍 문제점
![](https://hackmd.io/_uploads/B17nL66Hn.png)
초기 객체 관계를 설계도를 참고하여 코드를 작성한 결과 발생한 문제는 아래와 같습니다.

1. 보일러 플레이트 코드가 많음(Todo / Doing / Done List를 관리하는 ViewController)
2. ViewModel과 ViewController의 역할의 부적절한 설계
    * DiffableDataSource, Snapshot의 관리를 ViewModel이 하고 있던 문제
    * Todo/Doing/Done List 각각의 확장성을 고려하지 않았던 문제
3. Protocol을 통한 추상화에 따라 코드가 더 복잡한 depth / 관계를 가져 가독성 / 객체관계 파악이 어려움
4. List를 구현할 뷰를 TableView에서 CollectionView로 설계 수정 없이 변경한 문제

</br>

### ⚒️ 해결방안
* MVVM 아키텍처에 대한 추가 자료 조사 및 학습
* Class Diagram 재설계

![](https://hackmd.io/_uploads/BJNgOhaH2.jpg)
![](https://hackmd.io/_uploads/HJA763TS2.jpg)

**적용 결과**
1. CollectionView를 관리하는 뷰컨트롤러를 하나의 타입(TaskCollectionViewController)으로 개선하여 해결
2. DiffableDataSource와 Snapshot 객체의 위치를 TaskCollectionViewController 내부로 변경
3. 복잡한 관계성을 최소화하는 방향으로 Protocol 추상화 설계(TaskListViewModel Protocol 정의, 적절한 Delegation 패턴을 위한 Protocol 정의)
4. UML 재설계 후 CollectionView 사용을 명시

</br>

### ⚒️ 추가 개선안
![](https://hackmd.io/_uploads/BJFSpXDI3.jpg)
이벤트 스트림을 관리가 필요한 뷰 모델에 Input / Output을 정의하여 ViewController에서만 구독이 일어나도록 설계

**적용 결과**
1. `@Published` attribute를 제거하여 planList fetch 이후 불필요한 filter-distribute 과정이 없도록 개선
2. view model의 `transform(input:)` 메서드를 활용하여 ViewController에서만 구독 진행
3. DiffableDataSource에 Snapshot apply 시, 불필요한 reload가 없도록 개선

</br>


## 2️⃣ 요구사항에 맞는 레이아웃 설계.
한 화면에 3개의 테이블 뷰가 보여지는 화면을 구현하는 요구사항이 존재했습니다.

초기에는 하나의 컬렉션 뷰에서 컴포지셔널 레이아웃을 사용한다면 각각의 화면에 접근이 쉬워진다고 생각하여 이 방법을 채택했습니다.

</br>

### 🔍 문제점
하지만 이를 구현하면서 다음의 문제가 발생했습니다.
-  section header가 셀 내용과 겹쳐보이는 문제. 
-  각각의 섹션을 listConfiguration을 사용하여 구성했을 때 section의 크기를 잡지 못하는 문제. 
    - 이를 해결하기 위해 각각의 섹션을 list형식이 아니라 compositionalLayout으로 구성했지만 trailingSwipeActionsConfigurationProvider을 추가하지 못하는 문제가 또 발생함.
    -  delete하는 것처럼 보여지는 스크롤뷰를 만들 수는 있으나 애플에서 지원하는 SwipeAction기능을 사용하지 않고 있기에 이때부터 설계가 잘못되었다고 생각.
- 하나의 뷰모델에서 모든 기능을 관리하기에 확장성이 낮아지는 문제. 

<br/>

```swift
 private func collectionViewLayout() -> UICollectionViewLayout {
    let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
    layoutConfiguration.scrollDirection = .horizontal

    let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil,
                                                          top: .flexible(50),
                                                          trailing: nil,
                                                          bottom: nil)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        // 헤더 설정.
        // deleteAction 커스텀 구현해야 함.

        return section
    }, configuration: layoutConfiguration)

    return layout
}
```

</br>

###  ⚒️ 해결방안

위 문제들을 고려했을 때 하나의 컬렉션뷰에서 관리하기 보다는 3개의 컬렉션 뷰를 만드는 것이 좋다고 생각하여 이 방법으로 변경했습니다.

변경이후 다음의 장점이 있었습니다.

- 확장성을 증가시키고 유지보수 용이하게 만들어 개방폐쇄원칙 준수.
- 각각의 뷰가 뷰모델에 1:1관계를 맺고있기 때문에 단일책임원칙을 준수.
- 복잡한 1개의 레이아웃에서 간단한 3개의 레이아웃 구성하여 가독성 증가.

<br/>

```swift
private func collectionViewLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        // 헤더 설정
        // 애플이 적용하는 UIContextualAction사용하여 Delete 구현.

        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.interGroupSpacing = 10

        return section
    }

    return layout
}
```

</br>

## 3️⃣ 여러개의 아이템이 리로드 되는 문제

### 🔍 문제점
컬렉션 뷰의 데이터소스로 존재하는 배열이 변경될 때마다 스냅샷에서 그 배열의 전체 id를 가져와 `reloadItems`를 사용하여 업데이트 했습니다.
```swift
func bind() {
    viewModel.$planList
        .sink { isUpdating, planList in
            if isUpdating {
                self.updateSnapshot(planList)
            }
        }
}

func updateSnapshot(planList: [Plan]) {
    let planIDList = planList.map { $0.id }
    let snapshot = Snapshot()
    snapshot.appendSection([.main])
    snapshot.reloadItems([planIDList])
    dataSource.apply(snapshot)
}
```
하지만 위 방법은 스냅샷에서 `hashable`한 모델 자체를 들고있는 것이 아니라 `id`만을 들고 있기 때문에 `id`에 해당하는 내용이 변경되더라도 `id`는 변경되지 않기 때문에 리로드되지 않는 문제가 발생했습니다. 

그래서 다음과 같이 변경했습니다.

```swift
func updateSnapshot(planList: [Plan]) {
    let snapshot = dataSource.snapshot()
    let planIDList = planList.map { $0.id }
    snapshot.reloadSection([.main])
    snapshot.reloadItems([planIDList])
    dataSource.apply(snapshot)
}
```

하지만 위 코드는 셀의 업데이트가 발생했을 때 전체를 리로드하는 문제가 존재했고 삭제기능 또한 마찬가지였습니다.
</br>

###  ⚒️ 해결방안

### 생성, 수정, 삭제에 대한 스냅샷 함수를 분리하여 문제를 해결했습니다. 

`taskList`자체를 구독하고 있다면 디테일한 기능을 정의 할 수 없었기 때문에 `taskList`를 `Publisher`로 두고있던 코드를 제거했습니다.

만약 스냅샷에서 관리하고 있는 것이 `id`가 아닌 `Hashable`한 모델이라면 `dataSource`에 전부 가져와서 `apply`만 호출했을때 `DiffableDatasource`가 자체적으로 차이를 비교하여 업데이트를 할 것이기 때문에 디테일한 기능을 정의할 필요가 없을 것입니다. 

하지만 현재 `DiffableDataSource`에는 `Hashable`한 모델을 들고다니는 것이 아닌 `UUID`를 들고다니기 때문에 디테일한 기능정의가 필요했기 때문에 `taskList`의 `Publisher`를 제거했습니다.

그리고 생성, 삭제, 수정 이벤트에 대한 `Publisher`를 정의했습니다.
```swift
protocol PlanListViewModel: AnyObject {
    var planList: [Plan] { get set }
    var planCountChanged: PassthroughSubject<Int, Never> { get }
    var planCreated: PassthroughSubject<Int, Never> { get }
    var planUpdated: PassthroughSubject<UUID, Never> { get }
    var planDeleted: PassthroughSubject<(Int, UUID), Never> { get }
    // ...
}
```
생성, 삭제, 수정이 일어났을 때 각각의 이벤트 퍼블리셔에 `send`를 통해 연관된 값(ex. 삭제될 id, 업데이트 될 id 등)을 발행함으로써 연관된 작업에 맞게 데이터소스가 변경될 수 있도록 했습니다.

```swift
// PlanCollectionViewController.swift 
private func bindState() {
    viewModel.planCreated
        .sink { [weak self] planListCount in
            self?.applyLatestSnapshot()
            self?.viewModel.planCountChanged.send(planListCount)
        }
        .store(in: &cancellables)

    viewModel.planUpdated
        .sink { [weak self] planID in
            self?.reloadItems(id: planID)
        }
        .store(in: &cancellables)

    viewModel.planDeleted
        .sink { [weak self] (planListCount, planID) in
            self?.deleteItems(id: planID)
            self?.viewModel.planCountChanged.send(planListCount)
        }
        .store(in: &cancellables)
}

private func applyLatestSnapshot() {
    let planIDList = viewModel.planList.map { $0.id }

    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(planIDList)
    dataSource?.apply(snapshot)
}

private func reloadItems(id: UUID) {
    guard var snapshot = dataSource?.snapshot() else { return }

    snapshot.reloadItems([id])
    dataSource?.apply(snapshot)
}

private func deleteItems(id: UUID) {
    guard var snapshot = dataSource?.snapshot() else { return }

    snapshot.deleteItems([id])
    dataSource?.apply(snapshot)
}
```


</br>

## 4️⃣ Event Stream이 끊어지는 문제
### 🔍 문제점
Combine을 활용하여 뷰에서 발생한 Event의 Publisher를 구독할 때, Stream이 ViewModel 내부에서 구독이 이루어져 다음과 같은 문제가 있었습니다.

1. 구독이 ViewController와 ViewModel에서 모두 이루어지고 있어 이벤트 처리 과정의 파악이 어렵다.
2. 구독의 수가 늘어나면 저장되는 cancellable의 인스턴스가 늘어나 메모리 사용량이 늘어날 것이다.

```swift
// ViewModel 구현부...
struct Input {
    let titleTextEvent: AnyPublisher<String?, Never>
    let bodyTextEvent: AnyPublisher<String?, Never>
}

struct Output {
    let isEditingDone = PassthroughSubject<Bool, Error>()
}

private var cancellables = Set<AnyCancellable>()

func transform(input: Input) -> Output {
    let output = Output()

    input.titleTextEvent
        .sink(receiveValue: { [weak self] title in
            guard let self else { return }

            self.title = title
            output.isEditingDone.send(true)
        })
        .store(in: &cancellables)

    input.bodyTextEvent
        .sink(receiveValue: { [weak self] body in
            guard let self else { return }

            self.body = body
            output.isEditingDone.send(true)
        })
        .store(in: &cancellables)

    return output
}
```

</br>

###  ⚒️ 해결방안
ViewModel에서 cancellables를 제거하고, operator를 통해 이벤트를 통해 받은 publisher를 가공하여 관련된 publisher를 하나의 스트림으로 merge했습니다.

merge된 publisher를 Output으로 전달해 ViewController에서만 구독이 1회만 일어나게 되어 연결된 스트림을 가질 수 있도록 해결했습니다.

```swift
struct Input {
    let titleTextEvent: AnyPublisher<String?, Never>
    let bodyTextEvent: AnyPublisher<String?, Never>
    let datePickerEvent: AnyPublisher<Date, Never>
}

struct Output {
    let isEditingDone: AnyPublisher<Bool, Error>
}

func transform(input: Input) -> Output {
    let titlePublisher = input.titleTextEvent
        .tryMap { [weak self] title in
            guard let title else { throw EditError.nilText }
            guard let self else { throw EditError.nilViewModel }

            self.title = title

            return true
        }

    let bodyPublisher = input.bodyTextEvent
        .tryMap { [weak self] body in
            guard let body else { throw EditError.nilText }
            guard let self else { throw EditError.nilViewModel }

            self.body = body

            return true
        }

    let datePublisher = input.datePickerEvent
        .tryMap { [weak self] date in
            guard let self else { throw EditError.nilViewModel}

            self.date = date

            return true
        }

    let isEditingDone = titlePublisher
        .merge(with: bodyPublisher, datePublisher)
        .eraseToAnyPublisher()

    return Output(isEditingDone: isEditingDone)
}
```

# ✨ 핵심경험

<details>
    <summary><big>✅ Combine</big></summary>
</br>

## Protocol
### Publisher
채택한 타입이 시간이 지남에 따라 일련의 값을 전송할 수 있음을 선언하는 프로토콜.
여러가지 구독 메서드를 통해 Subscriber에 자신의 변경사항을 알린다.

**Creating Your Own Publishers**
Publisher 프로토콜을 직접 구현하는 대신 Combine 프레임워크에서 제공하는 여러 타입 중 하나를 사용하여 고유한 Publisher를 만들 수 있다.

* `PassthroughSubject`와 같은 `Subject`의 구체적인 하위 클래스를 사용하여 `send(_:)` 메서드를 호출해 필요에 따라 값을 게시.
* `CurrentValueSubject`를 사용하여 subject의 기본 값을 업데이트할 때마다 값을 게시.
* 커스텀 타입의 속성에 @Published attribute를 추가하여 프로퍼티를 게시.

### Subscriber
Publisher로부터 input을 전달 받을 수 있는 타입을 선언하는 프로토콜.
Subscriber 인스턴스는 Publisher로부터 스트림의 요소를 전달 받는다.

Subscriber 인스턴스는 관계 변경을 설명하는 life cycle event와 함께 publisher로부터 스트림의 element를 받는다.

Publisher의 `subscribe(_:)` 메서드를 호출하여 subscriber와 publisher를 연결한다. 해당 메서드의 호출 이후 publisher는 subscriber의 `reveive(subscription:)` 메서드를 호출한다. 이후 publisher에게 element를 요청하고 선택적으로 구독을 취소하는 데 사용하는 subscription 인스턴스가 subscriber에게 제공된다.

Combine은 publisher 타입에 대한 연산자로 다음 subscriber를 제공한다. 

* `sink(receiveCompletion:receiveValue:)`: sink는 완료 신호를 수신할 때와 새 element를 수신할 때마다 제공된 클로저를 실행한다.
* `assign(to:on:)`: assign은 새로 받은 각 element를 지정된 인스턴스의 key path로 식별되는 프로퍼티에 할당한다.

</br>

### Subject
외부 호출자가 요소를 게시할 수 있는 메서드를 노출하는 Publisher.
`send(_:)` 를 통해 스트림에 어떤 값을 주입할 수 있다.

</br>

## Property Wrapper
### @Published
해당 프로퍼티 래퍼 attribute로 표시된 프로퍼티는 타입이 publish하게 된다.
* 게시된 프로퍼티의 publisher에는 프로퍼티 이름 앞에 $표시를 추가하여 접근할 수 있다.
* @Published 프로퍼티 래퍼는 class 프로퍼티에만 적용할 수 있다.

</br>

</details>

<details>
    <summary><big>✅ MVVM 활용</big></summary>

</br>

## Model
* 비즈니스 데이터를 가지고 있는 계층. 
* Repository에 데이터를 CRUD하는 로직이 존재.  

## View
* 뷰모델과 연결되는 바인딩이 존재.
* 그 외 레이아웃을 그리는 코드만 존재.
    
## ViewModel
* 데이터 바인딩 대상을 제공. 모델을 직접 노출하거나 특정 모델 멤버를 래핑하는 멤버를 제공.
* UIKit를 import하지않고 뷰에게 바인딩해주는 모델과 Presentation Logic만 존재.

## MVVM + Combine
![](https://hackmd.io/_uploads/Bk0XDVD8n.jpg)

Combine 라이브러리는 이벤트 처리 연산자를 결합하여 비동기 이벤트 처리를 커스터마이징할 수 있는 기능을 제공한다.

RxSwift 라이브러리와 동일한 기능을 제공하기 때문에 이벤트 스트림에 대한 이해를 위해 여러 자료들을 조사해보고 가장 이해에 도움이 되었던 이미지를 첨부했다.

MVVM에서 중요한 것은 View와 ViewModel의 바인딩이므로 스트림에 대한 이해가 필요했다.

학습했던 내용에서 중요한 점은 Stream의 구독이 ViewController에서 일어나야 한다는 것이었다. View에서 발생한 이벤트를 View Model 내부에 cancellable을 저장하여 구독하게 된다면 stream이 끊겨 어색한 코드가 될 수 있다.

</br>

</details>

<details>
    <summary><big>✅ Compositional Layout활용</big></summary>
</br>

## sectionProvider
* Section안의 요소 간 간격을 주기 위해 `UICollectionViewCompositionalLayout.list`사용이 아닌 `sectionProvider`적용.
## layout.scrollDirection
* 컬렉션 뷰 레이아웃이 스크롤되는 축을 결정하는 속성.
## section.orthogonalScrollingBehavior
* 현재 레이아웃방향의 수직방향으로 스크롤 스타일을 주는 속성.
</details>

---

</br>

# 📚 참고 링크

* [🍎 Apple Docs - Combine](https://developer.apple.com/documentation/combine)
* [🍎 Apple Docs - UIContextualAction](https://developer.apple.com/documentation/uikit/uicontextualaction)
* [🍎 Apple Docs - associatedtype](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/)
* [🍎 WWDC - Combine](https://developer.apple.com/videos/play/wwdc2019/722/)
* [🍎 WWDC - Combine in Practice](https://developer.apple.com/videos/play/wwdc2019/721)
* [곰튀김 - MVVM](https://www.youtube.com/watch?v=M58LqynqQHc)
* [Github - Combine-MVVM](https://github.com/mcichecki/combine-mvvm)
* [Github - todolist-mvvm](https://github.com/jalehman/todolist-mvvm)
* [Github - CombineCocoa](https://github.com/CombineCommunity/CombineCocoa)
* [Rx-MVVM의 올바른 사용법 - saebyuck_choom](https://velog.io/@dawn_dancer/iOS-Rx-MVVM%EC%9D%98-%EC%98%AC%EB%B0%94%EB%A5%B8-%EC%82%AC%EC%9A%A9%EB%B2%95-saebyuckchoom)
