# 프로젝트 매니저 README

# 📑 프로젝트 관리 앱
> 프로젝트 기간: 2022-07-04 ~ 2022-07-29
> 
> 팀원: [malrang](https://github.com/malrang-malrang), [Eddy](https://github.com/kimkyunghun3)
> 
> 리뷰어: [Lucas](https://github.com/innocarpe)

## 🔎 프로젝트 소개

프로젝트 관리 앱

## 📺 프로젝트 실행화면

## 👀 PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/119)
- STEP 2
    - [STEP 2-1](https://github.com/yagom-academy/ios-project-manager/pull/127)
    - [STEP 2-2](https://github.com/yagom-academy/ios-project-manager/pull/134)
    - [STEP 2-3](https://github.com/yagom-academy/ios-project-manager/pull/140)
    - [STEP 2-4, 2-5](https://github.com/yagom-academy/ios-project-manager/pull/146)
    - [STEP 2-6, 2-7](https://github.com/yagom-academy/ios-project-manager/pull/150)
- STEP 3
    - [STEP 3-1](https://github.com/yagom-academy/ios-project-manager/pull/152)
    - [STEP 3-2](https://github.com/yagom-academy/ios-project-manager/pull/158)

## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.0-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.0-blue)]()
- [![Realm](https://img.shields.io/badge/Realm-10.2-brown)]()
- [![Firebase](https://img.shields.io/badge/Firebase-9.0.0-yellow)]()
- [![Rxswift](https://img.shields.io/badge/Rxswift-6.5-hotpink)]()


## 🔑 키워드
- Swift Package Manager
- Realm
- Firebase
- Rxswift
- MVVM
- Popover
- Coordinator Pattern
- LongPressGesture

## ✨ 구현내용
[STEP 1]
- Swift Package Manager를 통해 라이브러리를 관리
- 로컬 DB로 Realm, remote DB로 Firebase 설치

[STEP 2-1, 2-2]
- TodoList 네비게이션 바 구현
- MVVM + Rxswift를 활용하여 TodoList TableView UI 구현
- 하나의 View로 status에 따라 Tableview 구분

[STEP 2-3, 2-4, 2-5]
- TodoList 생성, 편집, 삭제 기능 구현
- Popover를 통해 TodoList를 Todo, Doing, Done 이동

[STEP 2-6, 2-7]
- longPressGesture시 Popover창이 띄워지며 메뉴에 따라 원하는 Status로 가도록 구현
- 할일 목록 기한 초과시 DateLabel(TODO, DOING Status에서만)의 색상 변경 구현
 
[STEP 3-1, 3-2]
- 로컬 디스크인 Realm를 활용해 데이터를 저장, 삭제, 편집 기능 구현
- 리모트 디스크인 Firebase에 데이터 저장, 삭제, 편집 및 로컬 디스크와 동기화 기능 구현
- 네트워크 연결 유무에 따라 유저에게 알려주는 와이파이 image 구현

## 🤔 고민한점, 트러블 슈팅

## [STEP 1] 
### 로컬DB / 원격DB 라이브러리 선택

✅ **선택한 라이브러리**
로컬DB는 `Realm`/ 원격DB는 `Firebase Realtime Database` 로 결정했다.

**🤔 하위 버전 호환성에는 문제가 없는가?**
✅ 선택한 `Firebase Realtime Database`는 iOS 10, `Realm`는 iOS 8 부터 지원한다.
[iOS 및 IPad 사용현황](https://developer.apple.com/kr/support/app-store/)을 보게되면 IPad를 사용하는 유저의 90% 이상이 iOS 14 버전 이상을 사용하는것을 알수 있었고 하위 버전 호환성에 문제가 없다고 판단했다.

<img src = "https://i.imgur.com/YXe7g8z.png" width = "200">

**🤔 안정적으로 운용 가능한가?**
✅ Realm은 MongoDB의 서비스로 대중적으로 사용되어 검증된 기술이기 때문에 안정적인 운용이 가능할것으로 판단한다.

또한 Realm은 기존의 정형화된 데이터 베이스와 다르게 NoSQL 데이터베이스를 지향하며 Realm API를 사용해 좀더 직관적인 사용이 가능하며 데이터 처리 속도가 향상된 장점이 있다.
* Realm과 다른 DataBase의 성능비교 그래프

<img src = "https://i.imgur.com/wps0N9Q.png" width = "300"><img src = "https://i.imgur.com/5RBdKIF.png" width = "370">

[자료 출처](https://hesam-kamalan.medium.com/database-benchmark-realm-vs-snappydb-f4b89711f424)

✅ Firebase는 Google의 서비스로 Realm과 같이 대중적으로 사용되어 검증된 기술이기 때문에 안정적인 운용이 가능할 것으로 판단한다.

**🤔 미래 지속 가능성이 있는가?**
⚠️ Realm은 MongoDB에서 서비스 하고 있는 Third - Party 이므로 언제든 서비스가 종료될 위험을 가지고 있으나 충분한 성과를 내고 있는 라이브러리이며 지속적인 유지보수가 이루어지고 있기 때문에 지속 가능성이 있다고 판단한다.

⚠️ Firebase는 Google에서 서비스 하고 있는 Third - Party 이므로 언제든 서비스가 종료될 위험을 가지고 있으나 충분한 성과를 내고 있는 라이브러리이며 지속적인 유지보수가 이루어지고 있기 때문에 지속 가능성이 있다고 판단한다.

**🤔 리스크를 최소화 할 수 있는가? 알고 있는 리스크는 무엇인가?**
✅ Realm 사용 시 main thread가 아닌 다른 thread 접근하면 에러가 나는 리스크가 있다. 
해당 리스크를 해결하기 위해 Realm 접근 및 사용시 main thread에서 작업하도록 지정 해주어야한다.

⚠️ Firebase 사용 시 데이터베이스에 접근할 때 서버가 해외에 구축되어 있기 때문에 응답 시간이 조금 지연되는 경우 가 발생한다. 

## [STEP 2-1, 2-2]
### 3개의 다른 todoListItemStatus 가진 TableView 구현
<img src="https://i.imgur.com/7VpWBN7.png" width="700" height="350">

ProjectManager Project 의 기능은 Todo(해야할일)를 등록하고, todo(해야할일), doing(하고있는일), done(완료된일) 3가지 상태로 분류하여 UI에 표시해주는 기능을 갖게된다.

이를 구현하기위해 TableView를 3개 소유하도록 구현하였는데 각각의 테이블뷰는 화면에 어떤데이터를 보여주어야 하는지의 기능을 필요하게되고 각각의 todoListItemStatus(상태값)만 다르고 모두 동일한 기능을 구현해야하기 때문에 중복코드가 발생될것이라 판단했다.

이러한 문제점을 개선하기위해 UIView를 상속받는 ListView타입을 구현하고 ListView는 UITableView를 소유하고 있으며 todoListItemStatus(상태값)을 소유하도록 구현했다.

ListView타입 내부에서 상태값에따라 어떠한 것을 화면에 보여주는지만 정의해주어 중복코드 문제를 개선할수 있었다.

`Model`에 `todo`, `doing`, `done`를 가진 프로퍼티를 활용하여 각 `TableView`에 다른 `todoListItemStatus`를 가지도록 한다.

```swift
// Todo.swift
struct Todo {
    let todoListItemStatus: TodoListItemStatus
    let identifier: UUID
    let title: String
    let description: String
    let date: String
}
```

`ListView`에서 `ViewModel`에 있는 `tableViewData`를 활용하여 `items`와 `bind`하여 셀에 보여지도록 한다. 

```swift
// ListView.swift
private func bind() {
Observable.of(
            (TodoListItemStatus.todo, self.listViewModel.todoViewData),
            (TodoListItemStatus.doing, self.listViewModel.doingViewData),
            (TodoListItemStatus.done, self.listViewModel.doneViewData)
        )
        .filter { $0.0 == self.todoListItemstatus }
        .flatMap{ $0.1 }
        .asDriver(onErrorJustReturn: [])
        .drive(self.tableView.rx.items) { tabelView, row, element in
            guard let cell = tabelView.dequeueReusableCell(
                withIdentifier: TodoListCell.identifier,
                for: IndexPath(row: row, section: .zero)) as? TodoListCell
            else {
                return UITableViewCell()
            }
            cell.configure(element)
            self.listViewModel.changeDateColor(cell: cell, todoData: element)
            
            return cell
        }
        .disposed(by: self.disposeBag)
}
```

## [STEP 2-3, 2-4, 2-5]
### Coordinator Pattern
위의 [STEP2-1, 2-2] 구조로 프로젝트를 진행했기에 화면전환을 기능이 문제가 되었다.
tableView의 cell을 tap할경우와 navigationBar의 + 버튼을 tap할경우 DetailView로 화면을 전환해야 하는데 해당 기능을 ListView(tableView를 소유하고 있음), TodoListViewController(navigationBar를 소유하고 있음) 각각 구현해주어야 하는 문제가 발생했다. 

화면 전환 역할을 담당하는 Coordinator를 구현하여 화면전환을 필요로 하게되면 AppCoordinator에게 요청하는 방식으로 화면을 전환할수 있도록 구현하였다.

<img src="https://i.imgur.com/hoZY3g2.png" width="400">
<img src="https://i.imgur.com/VJDXp4y.png" width="401">

AppCoordinator를 구현함으로써 화면을 전환하는 기능의 중복코드 문제를 개선할수 있었고 추상화를 통해 View는 화면을 어떻게 보여줄것인지만을 정의할수있게 되었다.

## [STEP 2-6, 2-7]
### Reactive longPress ControlEvent 구현
tableView의 Cell을 longPress 할경우 Popover view를 보여주는 기능을 구현하기위해 tableView에 longPress Gesture를 추가 해주어야 했다.

RxSwift 라이브러리를 사용하고 있기에 RxGesture 라이브러리를 추가 하여 longPress ControlEvent 를 사용할수도 있었지만 RxGesture라이브러리의 longPress Gesture를 사용하더라도 longPress한 Cell의 데이터를 활용하기 위해서는 세부 로직을 구현해주어야하는 문제가 발생했다.

그렇다면 RxGesture 라이브러리를 추가하는것이 아닌 이번 프로젝트에서 좀더 쉽게 활용할 수 있도록 Reactive를 extension 하여 longPress ControlEvent를 구현하였다.

```swift
extension Reactive where Base: UITableView {
    func modelLongPressed<T>(_ modelType: T.Type) -> ControlEvent<(UITableViewCell, T)> {
        let longPressGesture = UILongPressGestureRecognizer(target: nil, action: nil)
        
        base.addGestureRecognizer(longPressGesture)
        let source = longPressGesture.rx.event
            .filter { $0.state == .began }
            .map { base.indexPathForRow(at: $0.location(in: base)) }
            .flatMap { [weak tableView = base as UITableView] indexPath -> Observable<(UITableViewCell, T)> in
                guard let tableView = tableView,
                      let indexPath = indexPath,
                      let cell = tableView.cellForRow(at: indexPath) else { return Observable.empty() }
                return Observable.zip(
                    Observable.just(cell),
                    Observable.just(try tableView.rx.model(at: indexPath))
                )
            }
        return ControlEvent(events: source)
    }
}
```
RxSwift tableView.rx의 modelselected, modelDeleted와 유사하게 사용할수 있도록 네이밍에 model을 키워드를 추가해주었다.

tableView의 modelLongPressed 이벤트가 감지될경우 어떤위치의 Cell인지 알수있도록 하고 어떤 데이터를 가지고 있는지 알수 있도록 외부에 전달 하도록 구현했다.

하지만 위와같이 구현했을때 기존에 구현해 두었던 tableView의 tap 이벤트가 감지되지 않는 문제가 발생했다.
tap, modelLongPressed 둘중 어떤 이벤트를 감지할지 알수 없게 된것이다.
문제를 해결하기 위해 ControlEvent에 우선순위를 설정할수 있을까? 고민하였고 modelLongPressed 이벤트 내부의 UILongPressGestureRecognizer 속성중 minimumPressDuration 을 활용하여 문제를 해결했다.

```swift
 let longPressGesture: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer(target: nil, action: nil)
            gesture.minimumPressDuration = 0.5
            return gesture
        }()
```
0.5초 이상 longPress 했을 경우에 인식되도록 수정하였다.

## [STEP 3-1, 3-2]
### DataManager를 활용하여 추상화 구현
DataManager에서 Local Database, Remote Database를 관리할 수 있도록 구현한다.

<img src ="https://i.imgur.com/Lm8A4EW.png" width="400">

DataManager를 사용하면 새로운 Database가 오더라도 이곳에서 관리하고 CRUD를 실행시키면 되기 때문에 최소한의 변경으로 구현이 가능해진다.

프토로콜을 통해 필요 기능들을 정의해두고 구현을 내부에서 해주는 방식으로 추상화했다.
```swift
protocol DatabaseManagerProtocol {
    var todoListBehaviorRelay: BehaviorRelay<[Todo]> { get }
    var networkStateBehaviorRelay: BehaviorRelay<Bool> { get }
    
    func create(todoData: Todo)
    func read()
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
}

final class DatabaseManager: DatabaseManagerProtocol {
        // 실제 구현이 이루어지는 곳
    private let realm = RealmDatabase()
    private let firebase = FirebaseDatabase()
}
```

### 로컬 디스크와 리모트 디스크 동기화 기능 구현
로컬 디스크에 저장된 데이터를 리모트 디스크에 동기화 하는 기능을 추가하기위해 고민 하였고
잘못 구현할 경우 로컬 디스크 혹은 리모트 디스크의 데이터가 소실될 위험이 있을것이라 생각했다.

데이터가 소실되지 않도록 동기화 기능을 구현하기위해 로컬 디스크, 리모트 디스크 둘중 어떤것을 프로젝트의 메인 디스크로 사용할것인지 고민하고 네트워크가 연결되지 않는 상황을 고려하여 로컬디스크를 메인 디스크로 사용하도록 했다.

로컬 디스크의 데이터를 리모트 디스크와 동기화 기능을 수행하는 시점은 아래와 같다.

- 앱 실행 시 리모트 디스크와 동기화하도록 한다.
- 앱 실행 중에 로컬 디스크 CRUD 기능 동작 시 리모트 디스크와 실시간 동기화하도록 한다.

동기화 기능은 아래와 같은 방식으로 이루어진다.
RealmDatabase에서 데이터를 생성 하게 되면 Completion를 통해 firebase에서도 데이터를 생성하며 실시간으로 생성이 되도록 한다.
이처럼 CRUD를 구현하여 동기화 기능이 동작하도록 한다.

```swift
func create(todoData: Todo) {
    self.realm.create(todoData: todoData) { todoData in
        self.firebase.create(todoData: todoData)
    }

    self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
}
```
