# ⏰ 프로젝트 관리 앱

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

## 🚀 trouble shooting

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




