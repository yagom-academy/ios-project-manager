# 📝 Project Manager

> 나의 Todo list를 `TODO`, `DOING`, `DONE` 상태별로 관리할 수 있는 앱
> 
> 프로젝트 기간: 2023.05.15-2023.06.02
> 
> <img src="https://img.shields.io/badge/swift-F05138?style=for-the-badge&logo=swift&logoColor=white">
> <img src="https://img.shields.io/badge/UIKit-2396F3?style=for-the-badge&logo=UIKit&logoColor=white">
> <img src="https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white">

## 팀원

| 혜모리 |
|:---:| 
|<Img src ="https://github.com/hyemory/ios-project-manager/blob/step2/images/hyemory.png?raw=true" width="200" height="200"/>|
|[Github Profile](https://github.com/hyemory)|

---
## 목차
1. [타임라인](#타임라인)
2. [프로젝트 구조](#프로젝트-구조)
3. [실행 화면](#실행-화면)
4. [트러블 슈팅](#트러블-슈팅) 
5. [참고 링크](#참고-링크)
6. [회고](#회고)

---
# 타임라인 

| 날짜 | 내용 |
| --- | --- |
| 2023.05.15 | 프로젝트에 적용할 라이브러리 조사 및 기술 스택 선정 |
| 2023.05.16 | 선정한 기술 스택과 선정 이유 정리하여 기록 |
| 2023.05.17 | FireBase 설치 및 MVVM 패턴 학습 |
| 2023.05.18 | 모델, 컬렉션 뷰 셀, 헤더 뷰 구현 |
| 2023.05.19 | 컬렉션 뷰 레이아웃 구현, MVVM 패턴 학습 |
| 2023.05.22 | GestureRecognizer로 스와이프 시 삭제하는 기능 구현 |
| 2023.05.23 | 컬렉션 뷰 리팩토링 (3개로 분리) |
| 2023.05.24 | MVVM으로 나머지 기능 (컬렉션 뷰 업데이트 및 팝오버) 구현 |
| 2023.05.25 | 휴식 |
| 2023.05.26 | Strategy 디자인 패턴 학습 |
| 2023.05.29 | 네이밍, 컨벤션 리팩토링 |
| 2023.05.30 | MVVM에 위배되는 객체 수정 (Model 객체 View Model 하위로 이동) |
| 2023.05.31 | MVVM에 위배되는 로직 수정 (View Model에서는 index 기준으로 수정) |
| 2023.06.01 | Collection View의 과한 책임으로인한 View Controller 구현 |
| 2023.06.02 | 코드 컨벤션 보완 및 프로젝트 회고 |

<br/>

---
# 프로젝트 구조
## Class Diagram

![](https://github.com/hyemory/ios-project-manager/blob/step2/images/Class%20Diagram.png?raw=true)

## File Tree
<details>
<summary> 파일 트리 보기 (클릭) </summary>
<div markdown="1">

```typescript!
├── Resource
│   ├── Assets.xcassets
│   ├── Base.lproj
│   │   └── LaunchScreen.storyboard
│   └── Info.plist
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Utility
│   └── AlertManager.swift
├── Extension
│   ├── CALayer+.swift
│   ├── Date+.swift
│   └── NotificationName+.swift
├── Protocol
│   └── IdentifierType.swift
├── View
│   ├── Detail
│   │   ├── DetailViewController.swift
│   │   └── WorkInputView.swift
│   └── Main
│       ├── HeaderReusableView.swift
│       ├── MainViewController.swift
│       ├── PopoverViewController.swift
│       ├── WorkCell.swift
│       └── WorkCollectionViewController.swift
└── ViewModel
    └── WorkViewModel.swift
```
    
</div>
</details>

---
# 실행 화면

| <center>초기 화면: 목록</center> |
| --- |
| ![](https://github.com/hyemory/ios-project-manager/blob/step2/images/workList.gif?raw=true) |

| <center>할 일 등록 화면</center> |
| --- |
| ![](https://github.com/hyemory/ios-project-manager/blob/step2/images/addWork.gif?raw=true) |

| <center>등록한 할 일 수정 화면</center> |
| --- |
| ![](https://github.com/hyemory/ios-project-manager/blob/step2/images/editWork.gif?raw=true) |

---
# 트러블 슈팅

## 1️⃣ 섹션의 헤더 뷰가 원하는대로 구성되지 않는 문제

### 🔍 문제점

![](https://github.com/hyemory/ios-project-manager/blob/step2/images/headerViewError.png?raw=true)

섹션별로 셀 데이터를 수정하는 구조를 가지고 있어, 처음에는 컬렉션 뷰 하나로 레이아웃을 커스텀하여 사용하였습니다.
그러나 캡쳐 화면과 같이 헤더 뷰와 아이템 그룹이 겹쳐 원하는대로 구성되지 않았습니다.

### ⚒️ 해결방안

[직접 커스텀한 Compositional Layout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayoutconfiguration)에서는 이번 프로젝트에 필요한 스와이프 버튼을 제공해 주지 않기도 하였습니다.
그래서 하나씩 뷰를 구성하는 [List configuration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)를 사용하여 컬렉션 뷰를 각각 3종 구성하는 방향으로 수정했습니다.
List configuration은 [iOS App Dev Tutorials - Delete a reminder](https://developer.apple.com/tutorials/app-dev-training/adding-and-deleting-reminders#Delete-a-reminder)의 예제와 같이 스와이프 버튼을 제공해줍니다.

## 2️⃣ reloadData

### 🔍 문제점

셀을 등록, 수정, 삭제할 때 컬렉션 뷰를 업데이트 해야하는데
`reloadData` 메서드를 사용하면 기존의 모든 데이터를 버리고 전체 데이터를 다시 불러와서 뷰를 업데이트합니다. 
이는 데이터가 크고 복잡한 경우에는 비효율적입니다.
몇 개의 변경된 항목만 있는 경우에도 전체 데이터를 다시 불러와야 하기 때문입니다.

### ⚒️ 해결방안

컬렉션 뷰를 업데이트하기위한 방법으로 `Snapshot`을 사용하였습니다.
View Model에서 데이터에 대한 변경사항이 발생하면 Notification을 post하여 컬렉션 뷰를 업데이트 해주도록 구현했습니다.

- `WorkViewModel`의 `addWork` 메서드

``` swift
func addWork(title: String, body: String, deadline: Date) {
    works.append(Work(id: UUID(), title: title, body: body, deadline: deadline))
    // 이 시점에 컬렉션 뷰를 업데이트 하기위해 noti post
    NotificationCenter.default.post(name: .worksChanged, object: nil)
}
```

- `WorkCollectionViewController`의 `applySnapshot` 메서드

``` swift
@objc private func applySnapshot() {
    var snapshot = Snapshot()

    if let currentStatus = WorkViewModel.WorkStatus.allCases.first(where: { $0.title == status.title }) {
        snapshot.appendSections([currentStatus])
        let works = viewModel.works.filter { $0.status == status.title }
        snapshot.appendItems(works, toSection: currentStatus)
    }

    workDataSource?.apply(snapshot, animatingDifferences: false)

    guard let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? HeaderReusableView else { return }

    configureHeaderView(headerView)
}
```

## 3️⃣ View 객체가 너무 많은 일을 하는 문제

### 🔍 문제점

기존에 설계한 내용은 `MainViewController`에 커스텀 컬렉션 뷰인 `WorkCollectionView` 타입의 인스턴스를 3개 만들어 사용하였습니다.

기존 코드에서는 `WorkCollectionView`에서 `데이터 소스` 세팅 및 `레이아웃`을 그리고, 이벤트가 발생하면 `delegate` 패턴을 사용하여 대리자(MainViewController)가 처리하도록 구현하였습니다.

``` swift
final class WorkCollectionView: UICollectionView {
    typealias DataSource = UICollectionViewDiffableDataSource<WorkViewModel.WorkStatus, WorkViewModel.Work>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WorkViewModel.WorkStatus, WorkViewModel.Work>
    
    weak var workDelegate: WorkCollectionViewDelegate?
    //...
```

그러나 MVVM에서의 View는 단순히 그리기만 하는 역할을 해야했습니다.

### ⚒️ 해결방안

View Controller가 그 역할을 담당하도록 수정하였습니다.
(`WorkCollectionViewController` 타입)
컬렉션 뷰는 UICollectionView의 인스턴스를 직접 만들어 전역 프로퍼티로 선언하였습니다. 
`MainViewController`에서 `addChild` 메서드를 이용해 `WorkCollectionViewController` 타입의 인스턴스 3개를 자식으로 추가했습니다.

---
# 참고 링크

## 공식 문서
- [iOS App Dev Tutorials - Delete a reminder](https://developer.apple.com/tutorials/app-dev-training/adding-and-deleting-reminders#Delete-a-reminder)
- [Collection views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [NSCollectionViewCompositionalLayout](https://developer.apple.com/documentation/appkit/nscollectionviewcompositionallayout)
- [NSCollectionViewCompositionalLayoutConfiguration](https://developer.apple.com/documentation/appkit/nscollectionviewcompositionallayoutconfiguration)
- [NSCollectionViewCompositionalLayoutSectionProvider](https://developer.apple.com/documentation/appkit/nscollectionviewcompositionallayoutsectionprovider)
- [UICollectionLayoutListConfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
- [NSCollectionLayoutSection](https://developer.apple.com/documentation/uikit/nscollectionlayoutsection)
- [NSCollectionLayoutContainer](https://developer.apple.com/documentation/uikit/nscollectionlayoutcontainer)
- [visibleItemsInvalidationHandler](https://developer.apple.com/documentation/uikit/nscollectionlayoutsection/3199096-visibleitemsinvalidationhandler)
- [UISwipeActionsConfiguration](https://developer.apple.com/documentation/uikit/uiswipeactionsconfiguration)
- [addChild(_:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621394-addchild)
- [setCustomSpacing(_:after:)](https://developer.apple.com/documentation/uikit/uistackview/2866023-setcustomspacing)

## 유튜브
- [곰튀김님 - MVVM](https://youtu.be/M58LqynqQHc)

## 블로그
- [[iOS] MVVM 디자인 패턴 정리 및 예제코드](https://lsh424.tistory.com/68)
- [swift MVVM 정리 및 예제](https://42kchoi.tistory.com/292)
- [iOS ) UICollectionReusableView](https://zeddios.tistory.com/998)
- [iOS) UIView 그림자 만들기](https://babbab2.tistory.com/41)

## 라이브러리
- [Apple 프로젝트에 Firebase 추가](https://firebase.google.com/docs/ios/setup?hl=ko)

---
# 회고

<details>
<summary> 회고 보기 (클릭) </summary>
<div markdown="1">
    
### 잘한 점

- 새로운 기술을 익히기 위해 먼저 선행 학습 후 프로젝트를 진행함
- MVVM 패턴을 구현하기 위해 3가지 원칙을 세움
    1. View Model에는 UIKit를 import하지 않을 것
    2. View에는 데이터를 조작하는 기능을 정의하지 않을 것
    3. View에서 작업을 직접 처리하지 않고 View Controller를 통해 처리하게 할 것
- 프로젝트 기한에 맞추기 위해 늦은 시간까지 열심히 진행함

### 아쉬운 점

- 일정 산정을 너무 촉박하게하여 컨디션 조절 실패
    
</div>
</details>
