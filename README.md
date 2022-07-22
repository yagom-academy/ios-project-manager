@@ -1,8 +1,6 @@

# 프로젝트 매니저 Read Me



> 프로젝트 기간: 2022-06-13 ~ 2022-07-01
> 
> 팀원: [우롱차](https://github.com/dnwhd0112), [파프리](https://github.com/papriOS) 
@@ -18,7 +16,7 @@ pod install 해주세요!

## 👀 PR
- [STEP1](https://github.com/yagom-academy/ios-project-manager/pull/121)
- [STEP2](https://github.com/yagom-academy/ios-project-manager/pull/143)
- [STEP3]

## 🛠 개발환경 및 기술스택
@@ -33,16 +31,30 @@ pod install 해주세요!

## 타임라인
- [x] 첫째주 : UI구현 및 기술 스택 선택
- [x] 둘째주 : UI구현, 요구사항 구현 및 코드 리펙토링
- [ ] 셋째주 : 

## 프로젝트 구조


## 프로젝트 실행 화면

|Task 생성|Task 삭제|
|------|---|
|![](https://i.imgur.com/GipSEzp.gif)|![](https://i.imgur.com/psPimMt.gif)|

|Task 이동|Task 수정|
|------|---|
|![](https://i.imgur.com/Jn8nJwl.gif)|![](https://i.imgur.com/1JsHxE8.gif)

|Task 수정취소|Task 생성취소|
|---|---|
|![](https://i.imgur.com/J8oQr2E.gif)|![](https://i.imgur.com/Ik7C79d.gif)|


## 🚀 트러블 슈팅
### STEP1️⃣ : UI구현 및 기술 스택 선택
---

### Realm 
| about | 장점 | 단점 |
@@ -52,7 +64,6 @@ pod install 해주세요!

MongoDB Atlas와 Device Sync로 클라우드 동기화를 지원한다.



### 선택 이유와 고려사항

@@ -77,8 +88,6 @@ MongoDB Atlas와 Device Sync로 클라우드 동기화를 지원한다.
| --- | --- |
| 최근 MongoDB가 인수하였기에 미래 지속가능성이 높아보인다. | 현재 여러 기업에 서비스를 하는 중임으로 미래 지속 가능성이 높다고 본다. |



#### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

#### Realm
@@ -89,11 +98,10 @@ realm은 `@ThreadSafe Wrapper`, `writeAsync` 등 여러 방법으로 thread safe
[Realm Threading](https://www.mongodb.com/docs/realm/sdk/swift/advanced-guides/threading/)
[perform a background write](https://www.mongodb.com/docs/realm/sdk/swift/examples/read-and-write-data/#std-label-ios-async-write)



#### MongoDB Atlas

파이어 베이스와 비슷한 기능을 제공하는것으로 알고있지만 관련 문서가 너무 적고 사용사례도 적다. Realm과 높은 연동성을 바라보고 사용할 예정이다. -> 못써먹겠다 요구하는게 너무 많다.
[공식 튜토리얼](https://www.mongodb.com/docs/realm/tutorial/ios-swift/)

#### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
@@ -103,9 +111,72 @@ realm은 `@ThreadSafe Wrapper`, `writeAsync` 등 여러 방법으로 thread safe
- SPM

우리는 `CocoaPod`을 이용하여 관리하였다. 
    
#### 6. 이 앱의 요구기능에 적절한 선택인가?
이 앱의 주요기능을 우리는
1. 프로젝트 관리
2. 다른 기기에서도 볼 수 있도록 동기화가 주 요소라고 생각한다.

---
### STEP2️⃣ : UI 구현, 요구사항 구현 및 코드 리팩토링



### 🚀하나의 ViewController에서 3가지 TableView를 관리하는 방법

TODO, DOING, DONE 3가지 Task의 종류를 담는 TableView 3가지가 필요했다.
```swift
enum TaskType: String, CaseIterable {
    case todo
    case doing
    case done
}
```
enum으로 케이스를 만든뒤

```swift
// private typealias DataSource = UITableViewDiffableDataSource<Int, Task>
private var dataSources: [TaskType: DataSource] = [:]
private var tableViews: [TaskType: UITableView]
```
Dictionary를 사용해 3가지 tableView와 dataSource를 관리했다.



### 🚀테이블과 데이터의 관리

UIDiffableTableViewDataSource를 사용하여 별도의 메모리에 저장될 데이터저장소(배열 등)을 따로 두지않고, dataSource로 데이터를 관리했다.

TableView의 dataSource에서 데이터(Task)를 삭제하는 과정에서 
해당 Task정보를 나타내는 cell의 indexPath 또한 알아야 했기 때문에
```swift
struct TaskInfo {
    let task: Task
    let type: TaskType
    let indexPath: IndexPath
}
```
TaskInfo 구조체를 만들어 이를 통해 관리했다.


## ✏️ 학습내용
`Realm`
`MongoDB Atlas`

pop view Controller 사용 법
별도의 뷰컨트롤러를 만들어준뒤 사용한다. 이때 띄우는 방향이나 사이즈는 다음과 같이 작성한다.

```swift=
let popoverController = PopoverViewController(taskInfo: taskInfo)
        popoverController.delegate = self
        popoverController.modalPresentationStyle = .popover 
        popoverController.preferredContentSize = CGSize(width: 200, height: 100) //사이즈 지정
        
        let popover = popoverController.popoverPresentationController
        popover?.sourceView = mainView.retrieveTableView(taskType: taskInfo.type) // 보여주는 뷰 설정
        popover?.sourceRect = CGRect(x: point.x, y: point.y, width: 0, height: 0 ) // 보여주는 위치 설정(width, height는 무시된다)
        popover?.permittedArrowDirections = .up // 보여주는 방향 설정
        
        present(popoverController, animated: true)
```

### STEP3️⃣ : 로컬 및 원격 Database 기능 연동

### 구현 화면

#### 네트워크 연결 된 상태에서 Task 생성/수정/삭제 함
![](https://i.imgur.com/tmbOhLo.gif)
> 로컬과 리모트 db 모두에 적용이 됩니다

#### 네트워크 연결하지 않아도 기존 데이터를 보여줌
![](https://i.imgur.com/ZgD5F0U.gif)
> 맥 네트워크를 꺼 둔 상태에서 앱을 실행하여 task를 추가합니다

![](https://i.imgur.com/OLGTct7.gif)
> 재실행 시 로컬에 저장되어 있어 기존 데이터를 잘 보여줍니다

#### 네트워크 연결이 안된 상태에서 로컬에 변화가 생기고 추후 네트워크에 연결됨

![](https://i.imgur.com/bCrOHcr.gif)
> 네트워크에 연결되는 순간 로컬에 생겼던 변화가 firebase에 적용됩니다

#### 리모트 db에서 생긴 변화를 로컬에 적용함
![](https://i.imgur.com/j61LZne.gif)
> 왼쪽 상단의 버튼을 누르면 로컬로 서버 데이터를 불러옵니다
