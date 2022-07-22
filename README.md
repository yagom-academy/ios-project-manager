# ⏰ 프로젝트 관리 앱 I

> 프로젝트 기간: 2022.07.04 ~ 2022.07.15 <br>
> 팀원: [marisol](https://github.com/marisol-develop), [OneTool](https://github.com/kimt4580)
> 리뷰어: [Tony](https://github.com/Monsteel)

## 🔎 프로젝트 소개
: Todo, Doing, Done으로 프로젝트를 관리하는 앱

## 📺 프로젝트 실행화면


## 👀 PR
[STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/129)

[STEP 2](https://github.com/yagom-academy/ios-project-manager/pull/149)

## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.2.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-15.2-red)]()

## 🔑 키워드
`SwiftUI` `MVVM` `@ObservedObject` `popover` `onLongPressGesture` `@Published`

## 📑 구현내용
- 프로젝트 수행을 위한 다양한 기술 (SQLite, CoreData, iCloud, Dropbox, Firebase, Realm, MongoDB)의 장단점을 비교하여 사용할 기술 선정
- CocoaPod으로 SwiftLint, Realm, Firebase 설치

| 1. Task 추가시 TODO에 Task 추가 | 2. Task Type별 이동 기능 |
| -------- | -------- |
| ![](https://i.imgur.com/TrYwd5e.gif) | ![](https://i.imgur.com/foYwhHB.gif) |

| 3. 기한이 지난 Task의 날짜 색상을 red로 표시 | 4. 스와이프 삭제 기능 |
| -------- | -------- |
|![](https://i.imgur.com/dLZIrao.gif) |![](https://i.imgur.com/ZeoK4UG.gif) |

## 📝 전체적인 구조

- `TaskViewModel`: Task마다 가지고 있는 ViewModel로, title, date, body변수가 Published로 선언되어 있다
- `ContentViewModel`: ContentViewModel이 가지고 있는 ViewModel이다. TaskViewModel을 ObservedObject로 갖고 있고, @Published로 선언된 todoTasks, doingTasks, doneTasks를 갖고 있다. 
    - `appendData()`: TaskViewModel에 접근해 todo/doing/done에 append해주는 메서드
    - `moveData(_ task: Task, from: TaskType, to: TaskType)`: task를 다른 배열로 이동시켜주는 메서드
- `ContentView`: `TodoView`, `DoingView`, `DoneView`를 NavigationView > HStack으로 보여주는 뷰
- `TodoView`, `DoingView`, `DoneView`: 구독하고 있는 contentViewModel에서 자신의 taskType에 맞는 array의 Task 요소들을 CellView를 통해 보여주는 View
- `CellView`: 위 3가지 타입의 뷰로부터 contentViewModel, cellIndex, taskType을 전달받아 ListRowView로 데이터를 표시하는 뷰
- `ListRowView`: `CellView`로부터 정보를 전달받아 직접 화면에 Text를 통해 정보를 보여주는 뷰
- `RegisterView`, `RegisterElementView`: NavigationView인 `RegisterView`가 `RegisterElementView`를 화면에 표시함
- `EditView`, `EditElementView`: NavigationView인 `EditView`가 선택된 Task의 정보를 `EditElementView`가 화면에 표시함

## 📖 학습한 내용

- Swift Package Manager와 CoCoaPods의 차이 

**Dynamic FrameWork**
<img src = https://i.imgur.com/syk2WY7.png, width = "80%">
- 동시에 여러 프레임워크 혹은 프로그램에서 공유하여 사용하기 때문에 메모리를 효율적으로 사용
- 동적으로 연결되어 있으므로, 전체 빌드를 다시 하지 않아도 새로운 프레임워크 사용이 가능
- Static Linker를 통해 Dynamic Library Reference가 어플리케이션 코드에 들어가고 모듈 호출시 Stack에 있는 Library에 접근하여 사용
> 💡 Xcode에서 Framework를 생성하면 기본적으로 Dynamic Framework로 생성됩니다.

**Static FrameWork**

<img src = https://i.imgur.com/Kl56y1D.png, width = "80%">

- Static Linker를 통해 Static Library 코드가 어플리케이션 코드 내로 들어가 Heap 메모리에 상주
- 따라서 Static Library가 복사되므로, Static Framework를 여러 Framework에서 사용하게 되면 코드 중복이 발생

**결론**
- 번들을 접근할 때는 스스로가 접근하는 것 보단 외부에서 Bundle의 위치를 주입받는 것이 좋으므로, 소스코드가 복사되는 Static Framework 보다는 Dynamic Framework를 사용하는 것이 더 나을듯 하지만, Dynamic Framework의 무분별한 사용은 App Launch Time을 증가시킨다.

**CoCoaPods**
- 기본적으로 모든 dependency를 Static Library로 링크하고로 link하고, build한다.
- Podfile에 `use_frameworks!`를 추가하면 Dynamic Framework Link하고, `use_frameworks! :linkage => :static`를 입력하면, Static FrameWork처럼 Link하고 build가 가능하다.
- 즉 CoCoaPods은 Static FrameWork처럼 사용할 수 도 있고, Dynamic FrameWork처럼도 사용할 수 있다. default는 Dynamic FrameWork이다.


**Swift Package Manager**
- SPM은 link와 build 방법을 설정 할 수 없도록 되어 있으므로, 무조건 Static Library를 사용할 수 밖에 없다.

**Library와 FrameWork**
- 공통점
    - 재사용 가능한 코드의 모음
    - 프로그래밍을 쉽게 할 수 있도록 도와주는 역할
- 차이점
    - Library: 앱의 흐름을 사용자가 직접 제어
    - Framework: 코드를 연결할 수 있는 위치를 제공하고, 필요에 따라 사용자가 연결한 코드를 호출하는 제어 흐름 권한을 갖는다

프레임워크는 정해진 매뉴얼과 룰을 제공하며, 프레임워크를 사용하려면 이 룰을 지켜야 한다.
하지만 라이브러리는 어떤 특정 기능을 구현하기 위해 미리 만들어진 함수의 집합이며, 필요할 때만 자유롭게 사용할 수 있는 `도구`이다.

참조 : 
[Podfile Syntax Reference](https://guides.cocoapods.org/syntax/podfile.html#use_frameworks_bang)
[Building a dynamic modular iOS architecture](https://medium.com/fluxom/building-a-dynamic-modular-ios-architecture-1b87dc31278b)
[Static, Dynamic Framework](https://velog.io/@dvhuni/Static-Dynamic-Framework)
[프레임워크와 라이브러리 차이점 쉽게 이해하기](https://velog.io/@nemo/framework-library-gfreqbgx)

## 🚀 trouble shooting

### 📌 IPHONEOS_DEPLOYMENT_TARGET Error

marisol은 `IPHONEOS_DEPLOYMENT_TARGET = 15.2;`
OneTool은 `IPHONEOS_DEPLOYMENT_TARGET = 15.5;`
으로 인하여, marisol의 Xcode에서 Simulator들을 사용할 수 없는 일이 발생하였고, 공통으로 `15.2`로 변경하여 Target을 맞춰 주었습니다.

### 📌 M1과 Intel의 FrameWork 설치 오류
서로의 아키텍처가 달라서, SwiftLint 오류가 발생하였고, `cocoapods`으로 `arch -x86_64 pod install`를 사용하여 `pod install` 해주었습니다.


### 📌  taskType이 각 Array안에서 변경이 되지 않음

처음에 설계할 때 모든 Task들이 자신의 type을 알고 있어야 한다고 생각했습니다. 
그래서 Task 구조체에 TaskType 타입의 type 프로퍼티를 선언해주었는데, ContentViewModel의 moveTask 메서드에서 Task 자신의 type이 아니라, from이라는 taskType 파라미터를 받아서 그걸 기준으로 다른 type의 array로 옮겨주기 때문에 Task들이 자신의 type을 알고 있을 필요가 없어졌습니다.
그래서 taskType을 model에서 제거해주고, 직접 해당하는 Array에 append 되도록 변경해주었습니다.

### 📌 TaskViewModel의 Task를 ContentViewModel의 todoTasks에 어떻게 접근해서 append 시켜줄수 있을까?

ViewModel을 총 2개를 만들었는데요,
1. 각 Task마다 가지고 있는 TaskViewModel
2. ContentView가 가지고 있는 ContentViewModel

처음으로 사용자가 우측 + 버튼을 눌러서 Task를 생성하는 상황에서,
TaskViewModel 내의 @Published var title, @Published var date, @Published body를 가지고 task를 생성해주고,
그 task를 ContentViewModel의 todoTasks에 append 시켜주고 싶었습니다
그래서 ContentViewModel이 TaskViewModel을 구독하도록 하고, 그 TaskViewModel에 접근해서 자신의 todoTasks에 append하도록하여 해결했습니다

```swift
class TaskViewModel: ObservableObject {
    var task: Task?
    var taskArray: [Task] = []
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var body: String = ""
    
    func addTask() {
        task = Task(title: self.title, date: self.date, body: self.body)
        if let finalTask = task {
            taskArray.append(finalTask)
        }
    }
}
```

```swift
class ContentViewModel: ObservableObject {
    @ObservedObject var data = TaskViewModel()
    @Published var todoTasks: [Task] = []
    @Published var doingTasks: [Task] = []
    @Published var doneTasks: [Task] = []
    
    func appendData() {
        data.addTask()
        if let task = data.taskArray.last {
            todoTasks.append(task)
        }
    }
}
```

# ⏰ 프로젝트 관리 앱 II

> 프로젝트 기간: 2022.07.18 ~ 2022.07.29 <br>
> 팀원: [marisol](https://github.com/marisol-develop), [OneTool](https://github.com/kimt4580)
> 리뷰어: [Tony](https://github.com/Monsteel)

## 🔎 프로젝트 소개
: Todo, Doing, Done으로 프로젝트를 관리하는 앱

## 📺 프로젝트 실행화면


## 👀 PR
[STEP 3](https://github.com/yagom-academy/ios-project-manager/pull/156)


## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.2.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-15.2-red)]()

## 🔑 키워드
`SwiftUI` `MVVM` `@ObservedObject` `popover` `onLongPressGesture` `@Published`

## 📝 전체적인 구조

- **`Model`**
    - `Task`: title, date, body, type(todo/doing/done) 정보를 갖고 있는 모델 객체

- **`View`**
    - `ContentView`: `AllListView`를 `NavigationView`로 보여주는 가장 상위 View
    - `AllListView`: `TODO`, `DOING`, `DONE` LIST를 보여주는 View
    - `CellView`: `AllListView`의 List 내의 각 Cell이며, `ListRowView`에게 정보를 전달해주는 View
    - `ListRowView`: `CellView`에게 전달받은 정보를 가지고 실제로 title, date, body Text를 보여주는 View
    - `RegisterView`, `RegisterElementView`: NavigationView인 `RegisterView`가 `RegisterElementView`를 화면에 표시함
    - `EditView`, `EditElementView`: NavigationView인 `EditView`가 선택된 Task의 정보를 `EditElementView`에게 전달하여 화면에 표시함
    - `HeaderView`: 각 TaskType에 맞게 헤더에 텍스트와 Task 갯수를 표시하는 View

- **`Service`**
    - `TaskManagementService`: 모든 task들이 있는 tasks 배열을 프로퍼티로 갖는 클래스이며, 추후에 Realm의 CRUD가 구현될 클래스

- **`ViewModel`**
    - `ViewModelType`: 모든 ViewModel이 상속받는 ObservableObject 객체로, 모든 ViewModel이 같은 `TaskManagementService`를 참조하도록 해준다

## 🚀 trouble shooting
### 📌 어떻게 모든 ViewModel이 같은 Service를 알도록 할수 있을까?

우선 `Todo`, `Doing`, `Done`으로 `array`가 쪼개져있었기 때문에 분기처리를 해줘야할 부분이 많아서 각 `Task`가 자신의 `type`을 알도록 `Task`의 프로퍼티로 `type`을 추가해주었습니다. 그리고 모든 `task`들이 모여있는 `tasks` 배열을 갖고 있는 `TaskManagementService`를 생성했습니다. 

많은 `ViewModel`에서 동일한 `TaskManagementService`를 알고 있어야 하기 때문에, `TaskManagementService`는 한 번만 초기화되고 모든 `ViewModel`들이 같은 `TaskManagementService`를 참조해야 한다고 생각했습니다.

그래서 `ViewModel`이 생성될 때마다 아래와 같이 `TaskManagementService` 주입이 필요했는데
```swift
var service: TaskManagementService

init(withService: TaskManagementService) {
    self.service = withService
}
```

모든 `ViewModel`이 초기화 될 때마다 위 코드를 작성해주기 번거로워서, `ViewModelType`이라는 `ObservableObject` 클래스를 만들어서 모든 `ViewModel`이 상속받도록 했고, `ViewModel`이 생성될 때 `TaskManagementService`를 주입받도록 해주었습니다. 

```swift
class ViewModelType: ObservableObject {
    var service: TaskManagementService
    
    init(withService: TaskManagementService) {
        self.service = withService
    }
}
```

결과적으로 App 구조체에서 `@StateObject`로 `TaskManagementService`를 선언해줘서 최상위 뷰의 뷰모델인 `ContentViewModel`에 주입해주고, 하위뷰의 뷰모델에게 주입해주는 식으로 구현했습니다. 

### 📌 CellView에서 Value가 변화될 때, 강제적으로 dismiss 되는 Bug?

`Sheet`를 띄워줄 때, `ViewModel`을 `ObservedObject`로 선언을 해주면 값이 하나라도 바뀌면 바로 dismiss 되는 버그가 있어서 `StateObject`로 변경해주었더니 정상적으로 작동하였습니다.

`ObservableObject`는 데이터에 변화가 있으면, `View`를 처음부터 다시 그리고, `StateObject`는 데이터를 사용하는 부분만 다시 그리기 때문에 `Sheet`로 띄워진 `View` 전체를 다시 그릴 필요 없이 `StateObject`를 사용하면 정상적으로 작동하게 되는 것 같습니다.

[@StateObject, @ObservedObject](https://wondev.tistory.com/5)



