# 프로젝트 매니저
> 해야할 일, 하고 있는 일, 완료한 일 등을 보여주는 아이패드 전용 Todo리스트 어플입니다.

### 프로젝트 핵심 경험
* UICollectionView
* NSDiffableDataSourceSnapshot
* UICollectionViewDiffableDataSource
* UIContextMenu

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

</details>

## 3. 프로젝트 구조

### 1️⃣ 폴더 구조
```
└── ProjectManager
    └── ProjectManager
        ├── Application
        │   ├── AppDelegate.swift
        │   ├── Base.lproj
        │   │   └── LaunchScreen.storyboard
        │   └── SceneDelegate.swift
        ├── Extension
        │   ├── Date+Extension.swift
        │   └── Notification.Name+Extension.swift
        ├── Info.plist
        ├── MainScene
        │   ├── View
        │   │   ├── TaskHeaderView.swift
        │   │   ├── TaskListCell.swift
        │   │   └── TodoTitleTextField.swift
        │   ├── ViewController
        │   │   ├── ListViewController.swift
        │   │   ├── MainViewController.swift
        │   │   └── TodoViewController.swift
        │   └── ViewModel
        │       ├── ListViewModel.swift
        │       ├── MainViewModel.swift
        │       └── TodoViewModel.swift
        ├── Model
        │   ├── GeneratedTaskError.swift
        │   ├── Task.swift
        │   ├── TaskState.swift
        │   └── TodoState.swift
        └── Resources
            └── Assets.xcassets
```
### 2️⃣ 클래스 다이어그램
![](https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/다이어그램.drawio.png?raw=true)

## 4. 실행화면

|할 일 삭제|할 일 수정|할 일 이동|할 일 추가|
|----------|----------|----------|----------|
|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20삭제.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20이동.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20이동.gif?raw=true" width=450 height=343>|<img src="https://github.com/fatherLeon/ios-project-manager/blob/step2/Images/할%20일%20추가.gif?raw=true" width=450 height=343>|

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

## 6. Reference
[Apple - Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
[Apple - UITextField: textRect(forBounds:)](https://developer.apple.com/documentation/uikit/uitextfield/1619636-textrect)
[Apple - UITextField: editingRect(forBounds:)](https://developer.apple.com/documentation/uikit/uitextfield/1619589-editingrect)
[Apple - CALayer: layer.shadowOffset](https://developer.apple.com/documentation/quartzcore/calayer/1410970-shadowoffset)
