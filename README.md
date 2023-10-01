# <img src = "https://hackmd.io/_uploads/B1r7f2cya.png" width = "35"> 프로젝트 매니저  <img src = "https://hackmd.io/_uploads/Bkf_435kT.png" width = "30"><img src = "https://hackmd.io/_uploads/rJhCN3qkp.png" width = "30">


- 프로젝트 기간: [2023년 9월 18일 ~ 10월 6일](https://github.com/WhalesJin/ios-project-manager/wiki/타임라인)
- 프로젝트 팀원: [Whales <img src = "https://hackmd.io/_uploads/Bkf_435kT.png" width = "20">](https://github.com/WhalesJin) , [Minsup <img src = "https://hackmd.io/_uploads/rJhCN3qkp.png" width = "20">](https://github.com/agilestarskim)
- 프로젝트 리뷰어: [GREEN <img src = "https://hackmd.io/_uploads/H1pGWNoyp.png" width = "20">](https://github.com/GREENOVER)

---

## 📖 목차
🍀 [소개](#소개) </br>
💻 [실행 화면](#실행_화면) </br>
🛠️ [사용 기술](#사용_기술) </br>
👀 [다이어그램](#Diagram) </br>
🧨 [트러블 슈팅](#트러블_슈팅) </br>
📚 [참고 링크](#참고_링크) </br>
👩‍👧‍👧 [about TEAM](#about_TEAM) </br>

</br>

## 🍀 소개<a id="소개"></a>

<img src = "https://hackmd.io/_uploads/Bkf_435kT.png" width = "20"><img src = "https://hackmd.io/_uploads/rJhCN3qkp.png" width = "20"> : 하나의 프로젝트를 세분화하여 관리할 수 있는 어플리케이션입니다.
칸반보드를 사용하여 TODO, DOING, DONE으로 분류해 진행도를 한 눈에 확인할 수 있습니다.
각 셀을 길게 클릭하여 할 일의 상태를 변경할 수 있고 스와이프를 통해 삭제할 수 있습니다.
상단 바에 위치한 + 버튼을 눌러 새로운 셀을 추가하거나 기존의 셀을 클릭하여 수정할 수 있습니다.



</br>

## 💻 실행 화면<a id="실행_화면"></a>

| 기본 화면 |
| :--------: |
| <img src = "https://hackmd.io/_uploads/BkzTn1Pga.png" width = "600"> | 

| 새 할 일 추가 |
| :--------: |
| <img src = "https://hackmd.io/_uploads/rJC22ywgp.gif" width = "600"> |

| 기존 할 일 편집 |
| :--------: |
| <img src = "https://hackmd.io/_uploads/ByIcjJwlp.gif" width = "600"> | 

| 카테고리 변경 |
| :--------: |
| <img src = "https://hackmd.io/_uploads/r18qskPlT.gif" width = "600"> |


</br>

## 🛠️ 사용 기술<a id="사용_기술"></a>
| 구현 내용	| 도구 |
|:---:|:---:|
|UI|SwiftUI|
|아키텍쳐|클린 아키텍쳐|
|디자인패턴|MVVM|
|로컬 데이터|Realm|
|리모트 데이터|Firebase|

</br>

## 👀 Diagram<a id="Diagram"></a>
### 📐 UML

<img src = "https://hackmd.io/_uploads/HkGA5h9y6.png" width = "800">


</br>

# Separator

## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>

### 1️⃣ 기술스택 설정

#### 1. 뷰 드로잉 - SwiftUI
UIKit에 비해 다음과 같은 장점을 느껴서 SwiftUI로 선택하였습니다.
 - 뷰 그리기 간단하다.
 - 레이아웃 많이 시간 안 뺏김
 - 코드가 짧고 직관적이다.
 - 재밌다.

#### 2. 아키텍처 - 클린 아키텍처 + MVVM
프로젝트들의 코드를 보면 체계도 없는 것 같고, 복잡성이 많이 얽혀있는 느낌이라 이렇게 중구난방하지않고 규칙이 있거나 의존방향이 일정했으면 좋겠다는 생각을 했습니다.
이를 해결해주는 것이 의존성 규칙에 대한 얘기를 하는 `클린 아키텍처`라고 생각합니다. 클린 아키텍처는 이론적이고 추상적인 느낌이라 방법이 되게 다양해 보였고, 그 중에서도 저희는 MVVM을 접목해서
**클린 아키텍처를 기반으로 MVVM**을 구현해보았습니다.

#### 3. 로컬데이터 - Realm
CoreData에 비해 다음과 같은 장점들이 더 와닿아서 Realm으로 결정했습니다.
- 속도가 CoreData보다 훨씬 빠르다.
- 직관적인 API를 제공하고 있어 사용성이 좋다.
- 외부 라이브러리긴 하지만 MongoDB가 관리하고 있어 신뢰성이 높다.
- 문서 정리가 잘 되어있고 커뮤니티가 잘 생성되어있어 정보 습득이 빠르다.
- SPM을 지원한다.
- Entity Mapping할 때 CoreData보다 훨씬 편하다.
-> CoreData는 객체 생성 시 context가 필요하다.

#### 4. 리모트데이터 - Firebase
iCloud와 Firebase 중에 고민이 되어 두 가지를 비교해보고 결론적으로 Firebase가 현재 프로젝트에는 더 좋을 것 같다고 판단해서 Firebase로 선택하였습니다.

<img src = "https://hackmd.io/_uploads/H18Ofyvyp.png" width = 80>

- 편의성이 좋다. CoreData와의 연동이 좋다.
코어데이터를 상속받은 클래스 사용
[NSPersistentCloudKitContainer](https://developer.apple.com/documentation/coredata/nspersistentcloudkitcontainer)
- iCloud는 제공이 약하다.
- iCloud 계정을 쓰므로 친구가 되어있으면 저장 위치에 따라 접근 수준을 정할 수 있다.
- 의존성 관리도구 필요없다.
- [CloudKit](https://developer.apple.com/kr/icloud/cloudkit/)

<img src = "https://hackmd.io/_uploads/SyrlGJDy6.png" width = 110>

- 안드로이드랑 같이 공유가 가능하다. (포트폴리오로 좋다)
- 단점은 비싸다.
- 의존성 관리도구 : 코코아팟이나 **SPM**
- 안드로이드 커버나 커리어 → Firebase
- 제공해주는 서비스가 많다. All in One
    - 데이터베이스랑 셋팅이 다 되어있다.
    - 보안 솔루션도 다 설치되어있다.
- 데이터 센터. 서울도 존재한다.
- 기본요건이 아래와 같아서 하위 버전 호환도 문제 없다.
    - Xcode 14.1 이상
    - iOS 11 이상
- 단점: 직접 DB에 접근하니까 보안이 약하다

### 2️⃣ CUSTOM MODIFIER
🚨 **문제점** <br>
Custom View를 alert 형태로 띄우기 위한 방법을 모색했습니다. 기본 API는 주어지지 않아 직접 구현을 해야했습니다.

💡 **해결방법** <br>
ZStack으로 배경과 alert을 나누고 그 사이에 검은 불투명 뷰를 넣어 alert이 떠 있는 효과를 만들었습니다. binding을 이용해 최대한 SwiftUI API와 비슷하게 만들었습니다.
<br>


### 3️⃣ ViewModel 선언 방식
🚨 **문제점** <br>
처음엔 아래와 같이 ViewModel을 각 View 안에 중첩타입으로 구현했습니다. 이 방법은 ViewModel이란 이름을 각 뷰에서 중복해서 사용할 수 있다는 장점이 있습니다. 하지만 View에서 다른 View의ViewModel에 접근하려면 뷰이름.뷰모델 이런식으로 접근해야한다는 단점이 있었습니다.

```swift
extension KanbanView {
    final class ViewModel: ObservableObject { ... }
}

struct KanbanView: View {
    @ObservedObject var vm = ViewModel()
    ...
}
```

💡 **해결방법** <br>


전역적으로 사용 가능하게끔 따로 빼내어 타입을 생성하였습니다.
```swift
final class KanbanViewModel: ObservableObject { }
```
<br>

### 4️⃣ TaskFormView 재활용

🚨 **문제점** <br>
TaskFormView에서 Create와 Edit을 구현하기 위해 중복된 부분들을 어떻게 처리할까 고민했습니다.


💡 **해결방법** <br>

1️⃣ View의 init에서 분기처리

view를 init할 때 optional Task를 사용해, create일 경우 nil, edit일 경우 수정할 task를 주입하여 분기처리를 하였습니다. 단점은 init에 로직이 들어가 복잡해지고 기능이 추가될 때마다 수정할 부분도 많아지고 사용하지 않은 메소드들을 viewModel에 모두 집어넣어야한다는 문제가 있었습니다.

[Optional Task를 이용](https://github.com/WhalesJin/ios-project-manager/blob/f2d72324a03fabdb7f51d02ce3442bcc2aaa28e3/ProjectManager/ProjectManager/Presentation/Kanban/TaskForm/TaskFormView.swift)

2️⃣ Protocol을 이용해 구현하기

Create와 Edit을 관찰해보니 중복되는 부분이 많아서 프로토콜로 기능 정의 후 Create와 Edit의 ViewModel을 각각 따로 만들어서 뷰모델을 주입하는 형식으로 구현해봤습니다. 단점은 기능이 추가될 때마다 각 뷰모델에 똑같은 메소드와 프로퍼티를 억지로 만들어야한다는 단점이 있습니다.

[Protocol 사용](https://github.com/WhalesJin/ios-project-manager/blob/ddea938b958136009b59b3b63a54f7b339904648/ProjectManager/ProjectManager/Presentation/Kanban/TaskForm/TaskFormView.swift)

<br>


### 5️⃣  Move to 기능 구현하기
🚨 **문제점** <br>

기존 코드는 todos, doings, dones를 각각 분리된 배열로 구현되어있어서 한 배열에서 다른 배열로 변경하려면 기존 배열에서 remove하고 다른 배열에서 append 하는 방식으로 진행되어야 했습니다. 이렇게 짜게 되면 상태변화에 따른 메서드들의 중복이 늘어나 다른 방법을 고민해보았습니다.

```swift
func moveFromTodo(task: Task, to other: String) {
    if other == "DOING" {
        moveToDoingFromTodo(task: task)
    } else {
        moveToDoneFromTodo(task: task)
    }
}
    
func moveToDoingFromTodo(task: Task) {
    guard let index = todos.firstIndex(of: task) else { return }

    todos.remove(at: index)
    doings.append(task)
}
    
func moveToDoneFromTodo(task: Task) {
    guard let index = todos.firstIndex(of: task) else { return }

    todos.remove(at: index)
    dones.append(task)
}
```

💡 **해결방법** <br>

1️⃣ state 속성을 추가해 state를 기준으로 필터링하여 배열을 분리하였습니다.
이 방법은 실제로 요소를 다른 배열로 이동시키는 것이 아니라 상태만 바꿈으로서 이동하는 것처럼 보이게 할 수 있는 장점이 있습니다. 하지만 이 과정에서 원본 tasks 배열 순서대로 요소들이 보여지기 때문에 저희가 원하는 순서대로 보여지지 않았습니다. 따라서 요소의 순서를 어떤 기준으로 보여주어야할지 기획해야했고 결국 date를 기준으로 정렬하여 문제를 해결하였습니다.

```swift
@Published var tasks: [Task]
    
var todos: [Task] {
    return tasks.filter { $0.state == .todo }
}

var doings: [Task] {
    return tasks.filter { $0.state == .doing }
}

var dones: [Task] {
    return tasks.filter { $0.state == .done }
}

init(tasks: [Task] = []) {
    self.tasks = tasks
    self.tasks.sort { $0.date < $1.date }
}

func create(_ task: Task) {        
    tasks.append(task)
    tasks.sort { $0.date < $1.date }
}
```

<br>

## 📚 참고 링크<a id="참고_링크"></a>

- <Img src = "https://hackmd.io/_uploads/Hyyrii91T.png" width="20"/> [Firebase](https://firebase.google.com/?hl=ko)
- <Img src = "https://hackmd.io/_uploads/B1pu3oq1a.png" width="20"/> [Realm 설치](https://www.mongodb.com/docs/realm/sdk/swift/install/#std-label-ios-install)
- [🍎 Apple Docs: CloudKit](https://developer.apple.com/kr/icloud/cloudkit/)
- [🍎 Apple Docs: List](https://developer.apple.com/documentation/swiftui/list)
- [🍎 Apple Docs: ViewModifier](https://developer.apple.com/documentation/swiftui/viewmodifier)
- [🍎 Apple Docs: GeometryReader](https://developer.apple.com/documentation/swiftui/geometryreader)
- [🍎 Apple Docs: ScrollViewReader](https://developer.apple.com/documentation/swiftui/scrollviewreader)
- [🍎 Apple Docs: UnitPoint](https://developer.apple.com/documentation/swiftui/unitpoint)
- [📚 StackOverflow: ViewModel Protocol](https://stackoverflow.com/questions/59503399/how-to-define-a-protocol-as-a-type-for-a-observedobject-property)

<br>

---

## 👩‍👧‍👧 about TEAM<a id="about_TEAM"></a>

| <Img src = "https://hackmd.io/_uploads/r1elEh5ka.png" width="100"> | 🐬Whales🐬  | https://github.com/WhalesJin |
| :--------: | :--------: | :--------: |
| <Img src = "https://hackmd.io/_uploads/HkTfN2cyp.png" width="100"> | **Minsup** | **https://github.com/agilestarskim** |

- [타임라인 링크](https://github.com/WhalesJin/ios-project-manager/wiki/타임라인)
