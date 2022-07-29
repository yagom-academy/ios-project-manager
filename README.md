# 프로젝트 매니저 Read Me


> 프로젝트 기간: 2022-06-13 ~ 2022-07-01
> 
> 팀원: [우롱차](https://github.com/dnwhd0112), [파프리](https://github.com/papriOS) 
> 
> 리뷰어: [스티븐](https://github.com/stevenkim18)

## 🔎 프로젝트 소개

프로젝트 관리는! 프로젝트 매니저!

## 실행하기전
pod install 해주세요!

## 👀 PR
- [STEP1](https://github.com/yagom-academy/ios-project-manager/pull/121)
- [STEP2](https://github.com/yagom-academy/ios-project-manager/pull/143)
- [STEP3]

## 🛠 개발환경 및 기술스택
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-14.4-red)]()

|UI구현|local db|remote db|
|------|---|---|
|UIKit|Realm|MongoDB Atlas|


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

|Task 수정취소|Task 생성취소|변경 내역(History) 확인|
|---|---|---|
|![](https://i.imgur.com/J8oQr2E.gif)|![](https://i.imgur.com/Ik7C79d.gif)|![](https://i.imgur.com/nxvbuBX.gif)|

|네트워크 연결 시 realtime db 실시간 연동|
|---|
|![](https://i.imgur.com/wxOaZPo.gif)|



## 🚀 트러블 슈팅
### STEP1️⃣ : UI구현 및 기술 스택 선택
---

### Realm 
| about | 장점 | 단점 |
| --- | --- | --- |
| 빠르고, 반응적이고, 확장이 용이하다.저장, 동기화, 데이터 쿼리ing 을 간단하게 진행할 수 있게 해준다 | 데이터 객체를 Realm에 객체형태로 저장하여 DB에서 가져온 데이터를 가공과정없이 바로 사용할 수 있으며 ORM/DAO가 필요하지 않다.                  MongoDB Atlas와 Device Sync로 클라우드 동기화를 지원한다. 또한 쉽고 믿음직스럽게 앱 퍼포먼스를 낮추지 않고 디바이스에 데이터를 영구저장할 수 있다. | 3rd party 라이브러리 추가로 인해 앱의 크기가 늘어난다. SQLite나 Firebase에 비해 커뮤니티가 작다.          Ream의 sync 기능이 AWS에서만 가능하다. |
### MongoDB Atlas

MongoDB Atlas와 Device Sync로 클라우드 동기화를 지원한다.


### 선택 이유와 고려사항

    
#### 1. 하위 버전 호환성에는 문제가 없는가?
#### Realm
| Realm| MongoDB Atlas |
| --- | --- |
|Xcode 11.3 이상,  iOS 9 이상| 해당사항 없음 |


#### 2. 안정적으로 운용 가능한가?
| Realm| MongoDB Atlas |
| --- | --- |
| CoreData 보다 작업속도가 빠르고 Realm Studio를 통해 DB상태를 편하게 확인할 수 있다. MongoDB가 운영하기 때문에 안정적으로 운용 가능하다고 보인다.| Realm을 인수한 MongoDB사에서 만든 멀티 클라우드 애플리케이션 데이터 플랫폼이다. 데이터베이스를 배포 및 관리해주는 역할을 한다. |  



#### 3. 미래 지속가능성이 있는가?

| Realm| MongoDB Atlas |
| --- | --- |
| 최근 MongoDB가 인수하였기에 미래 지속가능성이 높아보인다. | 현재 여러 기업에 서비스를 하는 중임으로 미래 지속 가능성이 높다고 본다. |

#### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

#### Realm

* 멀티스레드 환경에서 Thread safety를 유의해야한다

realm은 `@ThreadSafe Wrapper`, `writeAsync` 등 여러 방법으로 thread safety한 코드를 작성할 수 있도록 지원하고 있다. 
[Realm Threading](https://www.mongodb.com/docs/realm/sdk/swift/advanced-guides/threading/)
[perform a background write](https://www.mongodb.com/docs/realm/sdk/swift/examples/read-and-write-data/#std-label-ios-async-write)


#### MongoDB Atlas

파이어 베이스와 비슷한 기능을 제공하는것으로 알고있지만 관련 문서가 너무 적고 사용사례도 적다. Realm과 높은 연동성을 바라보고 사용할 예정이다. -> 못써먹겠다 요구하는게 너무 많다.
[공식 튜토리얼](https://www.mongodb.com/docs/realm/tutorial/ios-swift/)

#### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
#### Realm
- CocoaPod
- Carthage
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

### STEP3️⃣ : Firebase 연동 및 실시간 동기화 적용, history 목록 구현

### 구현 기능

### 🚀 1. 로컬 db(realm)와 리모트 db(firebase realtime db) 간 동기화

#### 1-1. 네트워크 접속 시 오프라인에서 발생한 변경사항을 firebase realtime db에 적용

```swift
Database.database().isPersistenceEnabled = true
```
위의 코드로 디스크 지속성을 사용 설정

#### 1-2. Firebase 실시간 연동
서버로 부터 데이터 변경이 있을때 알람을 받을수 있도록 구성
추가 - DataEventType.childAdded
변경 - DataEventType.childChanged
삭제 - DataEventType.childRemoved

```swift
    func observe<T: FirebaseDatable>(_: T.Type) {
        let observeRef = T.path.reduce(database) { database, path in
            database.child(path)
        }
        
        observeRef.observe(DataEventType.childAdded) { snapshot in
            self.firebaseEventObserveDelegate?.added(snapshot: snapshot)
            // 
        }
        
        observeRef.observe(DataEventType.childChanged) { snapshot in
            self.firebaseEventObserveDelegate?.changed(snapshot: snapshot)
        }
        
        observeRef.observe(DataEventType.childRemoved) { snapshot in
            self.firebaseEventObserveDelegate?.removed(snapshot: snapshot)
        }
    }
```
다만 이때 처음 데이터를 받을때도 childAdded가 실행된다. 우리는 로컬 서버위주로 데이터를 구성했으므로 만약 로컬 데이터에 이미 데이터가 추가되어있다면 추가를 생략하는 코드도 넣어줬었다.

### 🚀 2. History 구현 - 변경내역 기록
앱 실행 시 현재 기기에서 변경한 내용이 있으면 해당 기기에서 수정한 History가 보이게끔 구성. 
히스토리를 보여줄때 위의 실시간 연동으로 추가하거나 업데이트 한것은 보여주길 원하지 않았다. 그러므로 로컬환경에서 추가, 수정, 삭제가 될때만 히스토리를 추가하도록 하였다. 
또한 historys 라는 배열에 만들어진 History객체를 저장하여 앱이 종료되면 해당 배열이 비워진다. - 즉 앱이 실행되고 종료될때까지만 기록을 하기로 하였다.

### 🚀 3. keyboard 문제 해결
keyboardLayoutGuide를 통해 DetailModalView의 TextView가 키보드에 가려지지 않도록 구현하고자 하였다.
적용하고 자 한 constraint가 제대로 작동하지 않은 문제가 발생하였다.

첫번째 원인: layout을 바꿀때 기존 layout의 해제를 해주지 않았다
```swift=
//문제가 된 부분, 그냥 새로운 constraint로 변경한다.
bottomConstraint = stackView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor)

//수정 - 기존 constraint를 해제하고 다시 활성화 시킨다.
bottomConstraint.isActive = false
bottomConstraint = stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
bottomConstraint.isActive = true
```
두번째 원인: keyboardLayoutGuide가 제대로 frame을 잡지 못하였다.
해당 문제는 해결하지 못해 다른 방법으로 constraint를 적용하였다.

### 🚀 4. TextView Layer 문제 해결
TextView 테두리에 그림자가 진 효과를 주기 위하여
```
textView.layer.masksToBounds = false 
```
해당 코드를 작성하였다.
이 때문에 textView에 해당 textView의 frame을 넘길 만큼 긴 글을 넣으면 
바깥까지 스크롤이 되는 문제가 발생하여 위의 코드를 삭제하고 검정 선의 테두리를 갖도록 변경하였다.
