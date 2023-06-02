# 프로젝트 매니저
> 할 일을 만들고 관리하는 앱입니다.
> * 주요 개념: `MVVM Pattern`, `Combine`,`Localization`, `Firebase`, `Realm`, `Network Monitor`
> 
> 프로젝트 기간: 2023.05.15 ~ 2023.06.02

### 💻 개발환경 및 라이브러리
<img src = "https://img.shields.io/badge/swift-5.8-orange"> <img src = "https://img.shields.io/badge/Minimum%20Deployment%20Target-14.1-blue">  <img src = "https://img.shields.io/badge/Realm-10.39.1-brightgreen"> <img src = "https://img.shields.io/badge/Firebase-9.6.0-brightgreen"> 

## ⭐️ 팀원
| kokkilE | Harry |
| :--------: |  :--------: |
| <Img src = "https://hackmd.io/_uploads/rJIFycpBh.jpg"  height="200"/> |<img height="200" src="https://i.imgur.com/8pKgxIk.jpg">
| [Github Profile](https://github.com/kokkilE) |[Github Profile](https://github.com/HarryHyeon) | 

</br>

## 📝 목차
1. [타임라인](#-타임라인)
2. [프로젝트 구조](#-프로젝트-구조)
3. [실행화면](#-실행화면)
4. [트러블 슈팅](#-트러블-슈팅)
5. [팀 회고](#-팀-회고)
6. [참고 링크](#-참고-링크)

</br>

# 📆 타임라인 
- 23.05.15(월) : 프로젝트 적용기술 선정
- 23.05.16(화) : FirebaseFireStore, Realm SPM으로 패키지 추가
- 23.05.17(수) : 도메인 모델 정의, 하나의 컬렉션뷰를 가지고 작업 상태를 의미하는 화면 구성
- 23.05.18(목) : 메인 화면에서 3개의 영역을 가지도록 화면 구성(각 영역은 작업 상태를 가지도록 함)
- 23.05.19(금) : 작업을 추가하거나 수정할 때 나타나는 화면 구성
- 23.05.22(월) : 헤더 뷰모델, 셀 뷰모델, 영역 뷰모델 정의 및 뷰와 바인드 작업 구현, 작업의 추가기능 구현
- 23.05.23(화) : 작업의 삭제기능(trailing swipe), 수정기능(long tap gesture, didselect delegate) 구현
- 23.05.24(수) : 전체적인 레이아웃 수정
- 23.05.25(목) : 전체적인 타입/메서드 네이밍 수정, 하드 코드 제거, 불필요한 bind 제거, 작업 추가시 내용 검사를 통한 버튼 활성/비활성 기능 구현
- 23.05.26(금) : 로컬 DB 관리타입 구현
- 23.05.29(월) : 작업의 추가/이동/삭제에 관한 History를 관리하는 타입 구현, 작업들이 로컬 DB에 동기화 되도록 구현
- 23.05.30(화) : History들이 로컬 DB에 동기화 되도록 구현
- 23.05.31(수) : 원격 DB를 관리하는 타입 구현, 작업과 History가 원격 DB에 동기화 되도록 구현
- 23.06.01(목) : 네트워크의 연결 상태를 감지하는 타입 구현, 연결시/연결 안되어 있을 시 UserInteraction과 Data를 최초에 Fetch 해오는 저장소를 다르게 구현
- 23.06.02(금) : History 내역을 보여주는 PopoverView를 동적으로 레이아웃 하도록 수정


</br>

# 🌳 프로젝트 구조
<details>
    <summary><big>📂 File Tree </big></summary>
    
``` 
└── ProjectManager
    └── App
        ├── AppDelegate.swift
        ├── SceneDelegate.swift
        ├── Resource
        │   ├── Assets.xcassets
        │   └── LaunchScreen.storyboard
        └── Source
            ├── Network
            │   └── NetworkMonitor.swift
            ├── Database
            │   ├── Protocol
            │   │   ├── DataTransferObject.swift
            │   │   └── DataAccessObject.swift
            │   ├── Local
            │   │   ├── Model
            │   │   │    ├── RealmTask.swift
            │   │   │    └── RealmHistory.swift
            │   │   └── RealmManager.swift
            │   ├── Remote
            │   │   └── FirebaseManager.swift
            │   └── Controller
            │       ├── TaskManager.swift
            │       ├── HistoryManager.swift
            │       └── ProjectManagerService.swift
            ├── Util
            │   └── Extension
            │       ├── Array+subscript.swift
            │       ├── DateFormatter+Deadline.swift
            │       └── UICollectionViewCell+IdentifierType.swift
            ├── Model
            │   ├── Task
            │   │   ├── MyTask.swift
            │   │   └── TaskState.swift
            │   └── History
            │       └── History.swift
            ├── Main
            │   ├── MainViewController.swift
            │   └── MainViewModel.swift
            ├── TaskList
            │   ├── Cell
            │   │   ├── TaskListCell.swift
            │   │   └── TaskListCellViewModel.swift
            │   ├── Component
            │   │   └── CountLabel.swift
            │   ├── Header
            │   │   ├── TaskListHeaderView.swift
            │   │   └── TaskListHeaderViewModel.swift
            │   ├── TaskListViewController.swift
            │   └── TaskListViewModel.swift
            ├── TaskForm
            │   ├── Extension
            │   │   ├── UITextField+publisher.swift
            │   │   └── UITextView+publisher.swift
            │   ├── TaskFormViewController.swift
            │   └── TaskFormViewModel.swift
            └── History
                ├── HistoryViewController.swift
                ├── HistoryCell.swift
                └── HistoryViewModel.swift
```
</details>

</br>

# 📱 실행화면

| **프로젝트 생성** | **프로젝트 편집** | 
| :---: | :---: |
| <img src="https://hackmd.io/_uploads/HJ8Jd5pB2.gif" width=400> | <img src="https://hackmd.io/_uploads/Hk4eF9TB2.gif" width=400>    | 

| **프로젝트 이동** | **프로젝트 삭제** |
| :---: | :---: |
| <img src="https://hackmd.io/_uploads/HJfQF9pSn.gif" width=400> | <img src="https://hackmd.io/_uploads/BJqrFqaS2.gif" width=400> |

| **프로젝트 변경에 대한<br>히스토리 기록** | **네트워크 연결 해제 시<br>프로젝트 작성/편집/이동/삭제 기능 비활성화** |
| :---: | :---: |
| <img src="https://hackmd.io/_uploads/rkSabfw83.gif" width=400> | <img src="https://hackmd.io/_uploads/rkOnGGwIn.gif" width=400> |

| **서버와 데이터 실시간 동기화** |
| :---: |
| <img src="https://hackmd.io/_uploads/rkFEXfPI2.gif" width=800> |

</br>

# 🚀 트러블 슈팅
## 1️⃣ 프로젝트 구조 설계
### 🔍 문제점
뷰모델이 직접 로컬DB와 원격DB에 접근 하는 등 너무 많은 기능과 정보를 가지고 있었습니다. 이에 따라서 로컬DB와 원격DB를 독립적으로 관리하지 못하는 문제들이 발생했습니다. 또한, 네트워크 연결 상태를 모니터링하여 연결되어 있을때만 원격DB의 데이터를 Fetch 해와야하는 기능이 필요했기 때문에 뷰모델에 너무 과한 로직이 필요했습니다.

### ⚒️ 해결방안
<img src="https://hackmd.io/_uploads/Bk5HJXvU2.png" width=800>

뷰모델이 서비스를 통해서 데이터의 CRUD 작업을 요청하면 서비스는 요청한 데이터를 뷰모델에게 반환하도록 하고 직접 로컬DB와 원격DB에는 접근할 수 없도록 분리하였습니다.

그리고 네트워크 연결을 모니터링 하여 네트워크의 상태가 변경되면 서비스는 이를 감지하여 적절한 위치(로컬/원격)에 데이터를 저장하거나 가져오는 작업을 수행하도록 하였습니다.

<br>

## 2️⃣ 서비스의 정의와 프로젝트 기획
- 저희가 진행하는 프로젝트가 사용자에게 제공해주는 서비스가 무엇인지를 정의하는 것에 고민을 많이 했습니다.
- 처음 생각했던 방향은 사용자에게 할일의 추가/수정/삭제 하는 단순히 할일 관리 서비스만 제공하는 것이라고 생각했습니다.
- 해당 서비스를 제공하기 위해서 로컬 데이터베이스, 리모트 서버 두 가지 다 동기화 해야하는 이유가 무엇일까에 대한 고민을 해봤습니다. 네트워크에 관한 문제까지 겹치게 되면서 로컬과 원격서버의 동기화에 대한 여러 문제가 발생할 수 있는 경우의 수를 생각했을 때, **네트워크가 없는 환경에서는 변경사항이 있어서는 안된다**는 결과를 도출했습니다.
- 예시로 아이폰의 메모앱에서는 로컬 환경의 메모와 iCloud 서비스를 활용한 메모의 폴더가 다르다는 점, 카카오톡 로컬환경에서 메세지가 작성되지 않고 예전 대화목록을 볼 수 있다는 점에서 프로젝트의 기획을 어떤 방향으로 할 지 정할 수 있었습니다.

<br>

## 3️⃣ 로컬DB와 원격DB의 동기화 문제
- 네트워크에 연결 되어있을 때와 연결 되지 않았을 때 어떤 방식으로 동기화를 해주어야할까 고민을 많이했습니다.
- 저희가 생각한 기획은 다른 Apple 기기에서도 원격 서버를 공유해서 데이터가 일치해야한다고 생각하고 기획하였습니다.
- 따라서 네트워크 연결이 되어있지 않은 기기에서 CRUD 작업을 했다가 갑자기 네트워크에 연결이되어 동시간대에 다른 기기에서 CRUD가 일어나면 충돌이 발생할 수 있을 여지가 있다고 생각했습니다.
- 결론적으로 네트워크 연결이 되어있는지를 감시하여 연결되어 있지 않다면, 로컬DB로부터 데이터를 읽어오고 추가/수정 버튼, 스와이프 액션, 롱탭 제스쳐를 비활성화하여 CRUD 작업이 발생하지 않도록하였고, 네트워크 연결이되면 서버에 있는 데이터로 동기화를 할 수 있도록 하였습니다.

<br>

## 4️⃣ 네트워크 연결 상태 감지
네트워크 연결이 유지되는 경우 서버와 데이터를 동기화하고, 네트워크가 연결되지 않았을 경우에는 **읽기** 기능만 동작하도록 구현하였습니다.

네트워크를 감지하는 기능을 구현하기 위해 `Network` 프레임워크의 `NWPathMonitor`를 활용했습니다.
``` swift
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    @Published var isConnected = false
    
    private init() {}
    
    func startMonitor() {
        let globalQueue = DispatchQueue.global()
        
        monitor.start(queue: globalQueue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
    }
    // ...
}
```

`NetworkMonitor`는 singleton 인스턴스로 앱 전역에서 공유되도록 구현하였습니다.
네트워크의 연결 상태는 데이터베이스 매니저와 뷰에서 감지할 필요가 있었습니다.
- 네트워크 연결이 유지되지 않을 경우 뷰에서 이를 감지하여 프로젝트의 생성/편집/삭제 기능을 막기 위해 UI를 변경해야 합니다.
- 네트워크 연결이 유지되지 않을 경우 DB매니저에서 이를 감지하여 서버와의 동기화 상태를 해제하고 로컬 데이터베이스와 동기화해야 합니다.

### 🔍 문제점
뷰가 네트워크의 연결 상태를 전달받기 위해 뷰모델이 `NetworkMonitor`를 참조하도록 구현하였습니다.
뷰모델이 네트워크의 상태를 직접 감지하고 로컬DB에 작업을 요청할 지 원격DB에 작업을 요청할 지 결정하도록 구현하였습니다. 그런데 이러한 구조에서는 여러 뷰모델에 네트워크 연결 상태에 대한 동일한 로직이 반복적으로 필요하다는 점과 뷰모델의 역할이 지나치게 많아지는 문제가 있다고 생각했습니다.

### ⚒️ 해결방안
**1️⃣ 프로젝트 구조 설계**의 그림과 같이 서비스(`ProjectManagerService`)를 설계하여, 서비스가 `NetworkMonitor`를 참조하고, 뷰모델이 서비스를 참조하여 네트워크의 연결 상태를 한번 더 추상화된 형태로 감지하도록 했습니다.
네트워크 상태에 대한 로직은 서비스가 담당하기 때문에 역할 분리 측면에서 구조가 개선되었다고 생각합니다.

<br>

## 5️⃣ 원격 데이터베이스와의 실시간 동기화
### 🔍 문제점
여러기기에서 동기화 할 수 있도록 하기 위해서 Firebase의 FireStore를 사용하고자 했습니다.
하지만 로컬에서 작업에 대한 CRUD를 할 때마다 FireStore에 데이터를 저장하고 다시 FireStore로부터 Fetch를 해야하는 문제점이 있었습니다.

### ⚒️ 해결방안
``` swift
func addListener<DTO: DataTransferObject> (_ type: DTO.Type,
                                    createCompletion: ((DTO) -> Void)? = nil,
                                    updateCompletion: ((DTO) -> Void)? = nil,
                                    deleteCompletion: ((DTO) -> Void)? = nil) {
    let collectionName = String(describing: type)
    let databaseReference = database.collection(collectionName)
    
    snapShotListener = databaseReference.addSnapshotListener { snapshot, error in
        snapshot?.documentChanges.forEach { diff in
            guard let dto = try? diff.document.data(as: type) else { return }
            
            if diff.type == .added {
                createCompletion?(dto)
                return
            }
            
            if diff.type == .modified {
                updateCompletion?(dto)
                return
            }
            
            if diff.type == .removed {
                deleteCompletion?(dto)
                return
            }
        }
    }
}
func removeListener() {
    snapShotListener?.remove()
}
```
위 코드와 같이 FireStore에서 제공하는 snapShotListener를 활용하여 FireStore 데이터의 변경에 대한 감지를 할 수 있었고, 변경에 대한 상태를 분기하여 추가/수정/삭제에 completionHandler로 대응할 수 있도록 하였습니다. 

그리고 네트워크의 연결을 모니터링하여 네트워크가 연결되있지 않을 경우에는 removeListener()를 통해 snapShotListener를 제거해주었습니다.

</br>

## 6️⃣ 작업 추가/수정 화면에서 완료 버튼의 활성/비활성화

### 🔍 문제점
TaskFormViewController에서 Done버튼이 항상 활성화 되어 있어 빈 작업으로 추가되거나 수정될 수 있는 문제가 있었습니다. 
따라서 빈 작업으로 추가되거나 수정되어 적용하지 않도록 해주는 기능이 필요하다고 생각했습니다.

### ⚒️ 해결방안
UITextField와 UITextView를 확장하여 Notrification Center로 textField와 textView의 textDidChangeNotification를 Publish 하도록 했습니다.

``` swift
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                             object: self)
        ...
    }
}

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        ...
    }
}

```

뷰에서 퍼블리셔를 구독해 뷰모델에 제목과 본문의 텍스트를 할당해주도록 했습니다.
``` swift
// TaskListViewController.swift
textView.textPublisher
        .assign(to: \.body, on: viewModel)
        .store(in: &subscriptions)
textField.textPublisher
         .assign(to: \.title, on: viewModel)
         .store(in: &subscriptions)
```

뷰 모델에서 두 개의 퍼블리셔를 합쳐서 구독하여 비어있는지 확인 후에 `isDone` 프로퍼티에 bool 값을 다시 할당 합니다.
``` swift
// TaskListViewModel.swift
Publishers
    .CombineLatest($title, $body)
    .map { (title, body) in
        !title.isEmpty && !body.isEmpty
    }
    .assign(to: \.isDone, on: self)
    .store(in: &subscriptions)
```

다시 뷰에서는 `isDone`을 구독하여 버튼을 활성화 시킬지 결정하도록 하였습니다.
``` swift
// TaskListViewController.swift
viewModel.$isDone
    .sink { [weak self] in
        self?.navigationItem.rightBarButtonItem?.isEnabled = $0
    }
    .store(in: &subscriptions)
```

</br>

## 7️⃣ 배열의 인덱스에 안전하게 접근하기
### 🔍 문제점
`UICollectionView`에서 선택된 cell의 정보를 업데이트하기 위해 다음과 같이 인덱스에 접근할 필요가 있었습니다.

``` swift
// TaskManager.swift
func update(task: MyTask) {
    guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        
    taskList[index] = task
}
```
하지만 배열의 인덱스에 직접 접근할 경우, 해당 배열의 범위를 초과하는 인덱스에 접근하게 되면 크래시가 발생하게 됩니다.

### ⚒️ 해결방안
앱의 크래시를 방지하고 안전하게 접근하고자 `Array`의 `subscript`을 다음과 같이 구현하였습니다.

``` swift
// Array+subscript.swift
extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let newValue,
                  indices ~= index else { return }
            
            self[index] = newValue
        }
    }
}
```
getter에서는 배열의 범위를 초과하는 인덱스에 접근할 경우 nil이 반환되도록,
setter에서는 배열의 범위를 초과하는 인덱스에 접근할 경우 아무런 동작도 하지 않고 종료하도록 구현하였습니다.

``` swift
// TaskManager.swift
func update(task: MyTask) {
    guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        
    taskList[safe: index] = task
}
```
이제 배열의 인덱스에 접근할 때 `safe` 레이블을 사용해 앱의 크래시를 방지하고 안전하게 접근이 가능합니다.

</br>

# 🫂 팀 회고
### 우리팀이 잘한 점
- 프로젝트 요구사항에 맞게 모든 기능을 구현한 점
- 처음 적용해보는 MVVM 아키텍처와 Reactive Programming이지만 열심히 학습하고 적용해본 점
- 처음 적용해보는 외부 라이브러리를 공식 문서에 기반해서 적절하게 적용한 점

### 우리팀이 노력할 점
- 추후에 꼭 테스트코드 작성해보기!
- Reactive Programming에 대한 이해도를 높이기 위해 추가적인 학습 진행하기!
- Mordern Collection View의 레이아웃에 대한 이해도를 높이기 위해 추가적인 학습 진행하기!

</br>

---

# 📚 참고 링크

* [Apple Docs - Combine](https://developer.apple.com/documentation/combine)
* [Apple Docs - UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
* [Apple Docs - UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
* [Apple Docs - popover(isPresented:attachmentAnchor:arrowEdge:content:)](https://developer.apple.com/documentation/swiftui/view/popover(ispresented:attachmentanchor:arrowedge:content:))
* [Apple Docs - intrinsicContentSize](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs - NotificationCenter.Publisher](https://developer.apple.com/documentation/foundation/notificationcenter/publisher)
* [Apple Docs - NWPathMonitor](https://developer.apple.com/documentation/network/nwpathmonitor)
* [github - A simple SwiftUI weather app using MVVM](https://github.com/niazoff/Weather)
* [Firebase - Firestore](https://firebase.google.com/docs/firestore?hl=ko)
* [MongoDB - Realm Swift SDK](https://www.mongodb.com/docs/realm/sdk/swift/)
