# 📱 프로젝트 관리 앱

# 🧰 적용 기술 선정

|UI|비동기 이벤트 처리|Local DB|Remote DB|의존성 관리 도구|
|:-:|:-:|:-:|:-:|:-:|
|[SwiftUI](https://developer.apple.com/kr/xcode/swiftui/)|[Combine](https://developer.apple.com/documentation/combine)|[Realm](https://github.com/realm/realm-swift)|[Firebase](https://github.com/firebase/firebase-ios-sdk)|[Swift Package Manager](https://www.swift.org/package-manager/)|

<br>

# ⚙️ STEP 2 - 모델 타입 구현

### 1️⃣ '할일'을 표현하기 위한 Task, TaskStatus 타입 구현

- 이번 프로젝트에서 다뤄야 하는 주요 `Entity`는 `할일(Task)`입니다.
- Entity 객체 간의 Identity 를 구별하기 위해 `id` 값을 let 프로퍼티로 선언했습니다.
- 그 외의 title, body, dueDate, status 는 변경될 수 있는 값이므로, var 프로퍼티로 선언했습니다.
- id 는 불변이지만, 그 외의 프로퍼티는 자주 수정될 수 있으므로, 값타입인 `구조체`에서 `mutating` 키워드를 붙이기 보다는, `클래스` 타입으로 모델을 구현했습니다.
- Task 인스턴스가 생성될 때, id 는 String 타입으로 자동 생성되도록 `이니셜라이저`를 만들었습니다.
- 기한(dueDate)은 `Firestore`와의 연동을 고려하여, Date 타입으로 입력 받은 후 `TimeInterval(Double)` 타입으로 변환합니다.
- Task 가 생성될 때는 기본적으로 `TODO` status 로 설정됩니다.
- Task 인스턴스 간의 `동일성(id 매칭)`을 확인할 때 `==` 연산자를 사용할 수 있도록 `Equatable` 프로토콜을 채택했습니다.

```swift
class Task: Equatable {
    
    let id: String
    var title: String
    var body: String
    var dueDate: TimeInterval
    var status: TaskStatus
    
    init(title: String, body: String, dueDate: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
        self.dueDate = dueDate.timeIntervalSince1970
        self.status = .todo
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}

enum TaskStatus {
    
    case todo
    case doing
    case done
}

```

<br>

### 2️⃣ 데이터 관리를 담당하는 TaskManager 타입과 추상화 프로토콜 구현

- TaskManager 클래스는 할일(Task)들을 `배열` 형태로 가지고 있습니다.
- 추후 3개의 `UITableView(List)`를 구현할 때 `DataSource`로서 데이터를 전달해야 하므로, Status 별로 배열을 필터링해주는 연산 프로퍼티를 3개 구현했습니다.
- 할일(Task)을 보여줄 때, dueDate 가 `오래된 순서대로 정렬`될 수 있도록, Property Observer `didSet`을 사용했습니다.
- 전체 데이터에 해당하는 tasks 배열이 항상 오래된 순서대로 정렬되어 있으므로, 연산 프로퍼티의 리턴값으로 나오는 배열에서도 정렬을 유지할 것입니다.
- TaskManager `기능의 추상화`를 위해 TaskManageable 프로토콜 구현했습니다.

```swift
class TaskManager: TaskManageable {
    
    private var tasks = [Task]() {
        didSet {
            tasks.sort { $0.dueDate < $1.dueDate }
        }
    }
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    func createTask(title: String, body: String, dueDate: Date) {
        let newTask = Task(title: title, body: body, dueDate: dueDate)
        tasks.append(newTask)
    }
    
    func modifyTask(target: Task, title: String, body: String, dueDate: Date) {
        target.title = title
        target.body = body
        target.dueDate = dueDate.timeIntervalSince1970
    }
    
    func changeTaskStatus(target: Task, to status: TaskStatus) {
        target.status = status
    }
    
    func deleteTask(target: Task) {
        tasks.removeAll(where: { $0 == target })
    }
}
```

<br>

# ⚙️ STEP 1 - 라이브러리 의존성 추가 및 환경 설정

### 1️⃣ SwiftUI -> UIKit Intergration

- UIKit 으로 만들어진 기존 프로젝트에 `SwiftUI` 프레임워크를 적용했습니다.
- 스토리보드와 ViewController.swift 파일을 삭제하고 `ContentView.swift` 파일을 만들어서 SwiftUI 스타일로 구성했습니다.
- [UIHostingController](https://developer.apple.com/documentation/swiftui/uihostingcontroller)를 이용하여 rootVC 를 `SwiftUI view`로 wrapping 했습니다.
  - 📄 참고 문서 -> [SwiftUI Views Displayed by Other UI Frameworks](https://developer.apple.com/documentation/swiftui/swiftui-views-displayed-by-other-ui-frameworks)

```swift
// SceneDelegate.swift

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let hostingVC = UIHostingController(rootView: ContentView())
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = hostingVC
    window?.makeKeyAndVisible()
}
```

<br>

### 2️⃣ Firebase, Realm 라이브러리 추가

- 데이터 저장을 위해 사용할 Firebase, Realm 라이브러리를 `Swift Package Manager`를 통해 의존성 추가했습니다.

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156405675-cccd5127-2ca4-4b02-bcee-9c66b0e8bef0.png" width="40%"></p>

<br>

### 3️⃣ Firebase Realtime DB 연동 체크

- Firebase 의 `Realtime Database` 기능을 사용하기 위해 [해당 블로그](https://ios-development.tistory.com/231?category=899471) 참고하여 테스트를 진행했습니다.
- SwiftUI 프레임워크에서는 viewDidLoad() 메서드를 사용할 수 없어서, [onAppear(perform:)](https://developer.apple.com/documentation/swiftui/view/onappear(perform:)) 메서드를 사용했습니다.

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156117315-5ea9a249-6310-4c35-bbfe-f84b0c3b4406.png" width="100%"></p>

<br>

### 4️⃣ Firebase Cloud Firestore 전환 및 연동 체크

- 기존에 Firebase `Realtime DB`를 사용하기로 했는데요, `Firestore`가 상대적으로 [더 업그레이드된 최신의 DB](https://firebase.google.com/docs/firestore/rtdb-vs-firestore?hl=ko)이고, 현업에서도 Realtime -> Firestore 로 전환하는 추세라는 조언을 들었습니다.
- Realtime, Firestore 간의 가장 큰 차이는 [과금 모델](https://firebase.google.com/pricing?hl=ko)이라고 생각했습니다.
  - `Free tier`에서는 둘 다 약 1GB 정도의 데이터만 저장할 수 있습니다.
  - Firestore 는 `하루 CRUD 횟수`에 제한이 있고 Realtime 은 저장된 데이터 크기, 다운로드 크기에 제한이 있습니다.
  - 즉, 큰 단위의 데이터 요청이 자주 발생한다면 Firestore 가 유리하고, 가벼운 데이터이지만 CRUD 요청이 많이 발생한다면 Realtime 이 유리합니다.
  - 이번 프로젝트에서 다루는 `데이터는 text 뿐`이고 이미지조차 없기 때문에, 데이터 크기는 작지만, CRUD 요청이 많이 발생할 것입니다.
  - 만약 `과금 모델`만을 고려하면 Realtime 을 사용하는 게 유리한 선택이지만, 그럼에도 저는 Firebase 의 최신 DB인 `Firestore`를 선택해 경험해보고자 합니다.
- Firebase SDK 중에서 `FirebaseFirestore`를 추가하고 `FirebaseDatabase`는 제거했습니다.
- 간단한 연동 테스트를 진행했습니다.

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156418104-ca47c24a-0123-479f-815e-535b02ea3bfc.png" width="70%"></p>

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156413686-30419ca2-e4db-4fb4-9e58-d0f39dbb4899.png" width="70%"></p>

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156414374-77a0022b-0387-4259-9785-19e009c2166b.png" width="100%"></p>

<br>

### 5️⃣ SwiftLint 추가

- `SwiftLint(린트)`는 SPM 을 지원하지 않습니다.
- 린트를 세팅하기 위해 `CocoaPods`를 추가하기엔 의존성 도구가 2개로 나뉘어져 관리의 불편함이 생길 거라 생각했습니다.
- [린트 공식 리드미](https://github.com/realm/SwiftLint#using-homebrew)를 참고하여, `Homebrew`를 이용해 린트 설치를 쉽게 완료했습니다.
- 세팅 순서
  - 터미널에서 `brew install swiftlint` 명령어를 입력합니다.
  - Xcode 의 `Build Phases`에서 `Run Script`를 추가합니다.
  - 프로젝트 직속으로 empty 파일을 만들고 파일명을 `.swiftlint.yml`로 설정합니다.
  - [SwiftLint Rule Directory](https://realm.github.io/SwiftLint/rule-directory.html)를 확인해서, 원하는 옵션을 추가해줍니다.

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156407115-ef3ae2b6-a488-4a3b-8f81-c44f72f7646a.png" width="50%"></p>

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156407140-79e8b335-aeb4-4b26-8acc-9261d06a104c.png" width="100%"></p>

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156407173-5fda4a53-e4cc-4d42-8371-9a5d5b06a674.png" width="100%"></p>

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156408060-a8ca8935-bea8-48b2-b8c3-23d433adc73a.png" width="40%"></p>

<br>

### 6️⃣ Google Firebase API Key 노출에 대해서

- Firebase 연동을 위해 추가한 `GoogleService-Info.plist` 파일을 깃헙에 푸시하고 잠시 후에 [GitGuardian](https://www.gitguardian.com/) 이라는 곳에서 이메일을 받았습니다.
- 민감 정보인 `Google API Key`가 public repo 에 노출되었다는 경고였는데요.
리뷰어와 논의하고 구글링을 해본 결과, 굳이 숨겨줄 필요가 없는 것으로 판단했습니다.
  - 📄 참고 문서 -> [Firebase API Key를 공개하는 것이 안전합니까?](https://haranglog.tistory.com/25)

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156119042-3dd7ccfe-f2f2-410f-b410-03a720c44906.png" width="70%"></p>

