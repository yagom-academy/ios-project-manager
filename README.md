# 프로젝트 매니저
> 해야할 일, 하고 있는 일, 완료한 일 등을 보여주는 아이패드 전용 Todo리스트 어플입니다.

### 프로젝트 핵심 경험
* Realm
* Firebase
* NWMonitor
* UIContextMenu
* UICollectionView
* NSDiffableDataSourceSnapshot
* UICollectionViewDiffableDataSource

---
## 목차 📋
1. [팀원 소개](#1-팀원-소개)
2. [타임 라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행화면)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [Reference](#6-Reference)
7. [팀 회고](#7-팀-회고)

---
## 1. 팀원 소개
|레옹아범|
|:--:|
|<img src="https://github.com/hyemory/ios-bank-manager/blob/step4/images/leon.jpeg?raw=true" width="150">|
| [<img src="https://i.imgur.com/IOAJpzu.png" width="22"/> Github](https://github.com/fatherLeon) |

## 2. 타임라인
    
|날짜|진행 내용|
|:--:|:--:|
|2023.5.15.(월)|기술 스택 사전조사|
|2023.5.16.(화)|기술 스택 결정 및 프로젝트 환경 설정|
|2023.5.17.(수)|Model 설계|
|2023.5.18.(목)|MainViewController UI 구현|
|2023.5.19.(금)|README 작성 및 TodoViewController 구현|
|2023.5.22.(월)|에러 처리 UI 구현|
|2023.5.23.(화)|할 일 삭제 및 수정 구현|
|2023.5.24.(수)|특정 날짜 UILabel 색 변경, UIContextMenu 구현|
|2023.5.25.(목)|전체 코드 리팩토링|
|2023.5.26.(금)|README 작성|
|2023.5.29.(월)|Realm 데이터베이스 CRUD 구현|
|2023.5.30.(화)|Firebase 데이터베이스 CRUD 구현|
|2023.5.31.(수)|앱 테스트 및 오류 수정|
|2023.6.1.(목)|전체 코드 리팩토링|
|2023.6.2.(금)|README 작성|

</details>

## 3. 프로젝트 구조

### 1️⃣ 폴더 구조
```
.
└── ProjectManager
    └── ProjectManager
        ├── Application
        │   ├── AppDelegate.swift
        │   ├── Base.lproj
        │   │   └── LaunchScreen.storyboard
        │   └── SceneDelegate.swift
        ├── Extension
        │   ├── Date+Extension.swift
        │   ├── Notification.Name+Extension.swift
        │   └── UIViewController+Extension.swift
        ├── GoogleService-Info.plist
        ├── Info.plist
        ├── ListScene
        │   ├── View
        │   │   ├── TaskHeaderView.swift
        │   │   └── TaskListCell.swift
        │   ├── ViewController
        │   │   └── ListViewController.swift
        │   └── ViewModel
        │       └── ListViewModel.swift
        ├── MainScene
        │   ├── View
        │   │   └── HistoryCell.swift
        │   ├── ViewController
        │   │   ├── HistoryViewController.swift
        │   │   └── MainViewController.swift
        │   └── ViewModel
        │       └── MainViewModel.swift
        ├── TodoScene
        │   ├── View
        │   │   └── TodoTitleTextField.swift
        │   ├── ViewController
        │   │   └── TodoViewController.swift
        │   └── ViewModel
        │       └── TodoViewModel.swift        
        ├── Model
        │   ├── DataBase
        │   │   ├── DBManager.swift
        │   │   ├── LocalDBManager.swift
        │   │   ├── RemoteDBManager.swift
        │   │   └── TaskObject.swift
        │   ├── Error
        │   │   ├── DatabaseError.swift
        │   │   └── GeneratedTaskError.swift
        │   ├── History.swift
        │   ├── HistoryManager.swift
        │   ├── NetworkMonitor.swift
        │   ├── Protocol
        │   │   ├── DatabaseManagable.swift
        │   │   └── Storable.swift
        │   ├── Task.swift
        │   ├── TaskState.swift
        │   └── TodoState.swift
        └── Resources
            └── Assets.xcassets
                ├── AccentColor.colorset
                │   └── Contents.json
                ├── AppIcon.appiconset
                │   └── Contents.json
                └── Contents.json
```
### 2️⃣ 클래스 다이어그램
![](https://github.com/fatherLeon/ios-project-manager/blob/step3/Images/다이어그램.drawio.png?raw=true)

## 4. 실행화면

|할 일 삭제|할 일 수정|할 일 이동|할 일 추가|
|----------|----------|----------|----------|
|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20삭제.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20이동.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20이동.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20추가.gif?raw=true" width=450 height=343>|

|네트워크 연결 실패|네트워크 연결 성공|Firebase와 연결|
|----------|----------|----------|
|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step3/Images/네트워크%20연결%20실패시.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step3/Images/네트워크%20연결시.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step3/Images/RemoteEdit.gif?raw=true" width=450 height=343>|

## 5. 트러블 슈팅

### 1️⃣ UITableView vs UICollectionView
#### 고민한 점
* UITableView와 UICollectionView 두가지 UI중 어느것을 구현할지에 대해 고민했습니다.
* iOS14이상 부터 UICollectionView가 UITableView와 같은 리스트 형태의 UI를 제공합니다.
* UITableView의 경우 iOS2.0까지 하위 버전을 커버할 수 있으며, UICollectionView에 비해 풍부한 레퍼런스가 존재합니다.

#### UICollectionView 결정 이유
* 테이블 뷰와 UI측면에서 리스트로 보여진다는 점에서 큰 차이는 없지만 UICollectionView는 UITableView에 비해 다음과 같은 이유로 구현 이점이 있습니다.

1. Section마다 서로 다른 레이아웃을 가질 수 있다.
2. `reloadData()`, `performBatchUpdates(_:completion:)`를 사용하지 않고, UI에 보여질 데이터를 변경할 수 있으며, 자연스러운 애니메이션이 발생한다.
3. 상대적으로 확장성에 대한 이점을 가진다.

* 위와 같은 이유로 UICollectionView를 통하여 리스트형태의 UI를 구현하였습니다.

### 2️⃣ 그림자 렌더링 비용 문제
#### 문제점
```
The layer is using dynamic shadows which are expensive to render. If possible try setting `shadowPath`, or pre-rendering the shadow into an image and putting it under the layer.
```

* `UIView`의 경우 `layer`프로퍼티의 `shadowColor`, `shadowOpacity`, `shadowOffset`등 그림자 관련 프로퍼티만 값을 할당하여 그림자를 생성할 경우
* UI 디버깅 시 위와 같은 경고메시지가 발생합니다.
* 이를 해결하기 위해 `layer.shadowPath`에 값을 할당하여 렌더링 시 비용문제를 해결하였습니다.
#### 해결법
```swift
let textFieldShadowPath = CGPath(rect: titleTextField.bounds, transform: nil)
titleTextField.layer.shadowPath = textFieldShadowPath

let textViewShadowPath = CGPath(rect: parentTextView.bounds, transform: nil)
parentTextView.layer.shadowPath = textViewShadowPath
```

* 위와 같이 뷰의 크기에 대한 `CGRect`를 부여하여 `CGPath`를 생성한 후 `shadowPath`에 할당하였습니다.

### 3️⃣ 할 일 이동 뷰 UIAlertController vs UIContextMenu
#### 고민한 점
* UIAlertController의 경우 `ActionSheet`를 쓸 경우 `popoverPresentationController` 프로퍼티를 사용하여 팝오버 형식의 뷰를 표시할 수 있습니다.
* `UIContextMenu`의 경우 `UICollectionView`의 `Delegate`내에 메소드 구현시 길게 터치하는 경우 표시되도록 구현할 수 있습니다.

#### `UIContextMenu` 선택 이유
* `UIAlertController`의 경우 따로 표시될 뷰의 위치를 설정해줘야하는데, 현재 구현한 앱의 경우 하나의 뷰 컨트롤러 내에 여러개의 뷰 컨트롤러가 포함되어 있기 때문에 정확한 위치를 표시하기 힘듭니다.
* `UILongPressGesture`구현 및 따로 해당 제스처의 위치에 해당하는 Cell을 고르는 등의 복잡한 작업이 구현되어야 합니다.
* 그러므로 `UICollectionView`의 `Delegate`에 존재하는 `collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration?`메서드를 활용하여 `UIContextMenu`를 구현하였습니다.

### 4️⃣ Realm의 쓰레드
#### 문제점
* Realm의 경우 읽고 쓰기 메서드가 `Realm`객체가 만들어지는 쓰레드와 같은 쓰레드에서 생성되어야 하는 문제가 있었습니다.
* 네트워크 사용 시 `Realm`의 데이터베이스와 동기화 할 경우 각각 다른 쓰레드에서 접근이 되는 경우가 있어 앱이 크러쉬 나는 경우가 존재했습니다.

#### 해결방법
* CRUD 중 하나의 메서드를 실행할 때 `Realm`객체를 만들어주는 방법을 선택했습니다.
* `Realm`의 경우 따로 객체를 재생성하여도 이전 내용이 사라지거나 저장이 되지 않는 등의 문제가 없었습니다.
* 따라서 `Realm` 객체를 메서드가 실행 시 다시 만들어주어 같은 쓰레드 내에서 동작할 수 있도록 구현하였습니다.

### 5️⃣ Realm의 `Object`타입 제너릭으로 활용
#### 문제점
```swift

* `Object`타입의 무언가를 사용하여 객체를 구현할 때

```swift
let dbObjects = realm.objects(Object.self)
```

* 위와 같이 객체 내에서 사용시

```
“Object type ‘RealmSwiftObject’ is not managed by the Realm. If using a custom `objectClasses` / `objectTypes` array in your configuration, add `RealmSwiftObject` to the list of `objectClasses` / `objectTypes`.”
```

* 위와 같이 `Realm`은 `Object`타입을 관리해주지 않기 때문에 커스텀으로 관리하라는 FatalError가 발생했습니다.

#### 해결방법

```swift
private let type: Object.Type

let dbObjects = realm.objects(type.self)
```

* 위와 같이 타입을 외부에서 주입하여 사용하는 방법

```swift
final class LocalDBManager<T: Object>: DatabaseManagable {
//....
    let dbObjects = realm.objects(T.self)
}

let dbManager = LocalDBManager<TaskObject>()
```

* 위와 같이 제너릭으로 사용하는 방법이 있었습니다.
* 기존 객체 생성시 `init`으로 타입을 넘겨주기보다는 아래와 같이 타입을 명시해주는 것이 조금 더 가독성이 좋다고 생각하여 아래와 같이 구현하였습니다.

### 6️⃣ 네트워크 상태에 따른 UI변화
#### 고민한 부분
* 첫 앱을 실행할 때 네트워크 상태, 앱 실행 중 네트워크 상태 변화에 따른 `Alert`을 표시해 사용자에게 현재 네트워크 상황을 알려주고 있었습니다.

![](https://github.com/fatherLeon/ios-project-manager/blob/step3/Images/네트워크x.png?raw=true)

* 다만, 이럴경우 앱을 오래 사용할 경우 사용자가 네트워크 상황을 다시 확인할 수 없다는 점, 읽기 기능을 제외하고 수정, 삭제, 생성을 막아야 된다는 점에서 Alert과 추가적인 UI변경이 필요했습니다.

#### UI의 변화
![](https://github.com/fatherLeon/ios-project-manager/blob/step3/Images/네트워크X시UI.png?raw=true)

* Alert을 표시해주는 것 뿐만아니라 우측 `NavigationItem.rightBarButton`을 비활성화 시키고 `title`에 따로 빨간색 원을 추가함으로 현재 네트워크가 연결되어 있지 않다는 것을 보여주도록 구현하였습니다.

## 6. Reference
[Apple - Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
[Apple - UITextField: textRect(forBounds:)](https://developer.apple.com/documentation/uikit/uitextfield/1619636-textrect)
[Apple - UITextField: editingRect(forBounds:)](https://developer.apple.com/documentation/uikit/uitextfield/1619589-editingrect)
[Apple - CALayer: layer.shadowOffset](https://developer.apple.com/documentation/quartzcore/calayer/1410970-shadowoffset)
[Firebase - Apple 플랫폼에서 데이터 읽기 및 쓰기](https://firebase.google.com/docs/database/ios/read-and-write?hl=ko)
[RealmSwift](https://www.mongodb.com/docs/realm-legacy/kr/docs/swift/latest.html)
