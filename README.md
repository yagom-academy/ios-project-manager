# 프로젝트 매니저
> 할 일을 만들고 관리하는 앱입니다.
> * 주요 개념: `UITextView`, `UITextField`,`UICollectionView`, `MVVM Pattern`, `Combine`,`Localization`, `Firebase`, `Realm`
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
3. [실행화면](#-실행-화면)
4. [트러블 슈팅](#-트러블-슈팅)
5. [참고 링크](#-참고-링크)

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


</br>

# 🌳 프로젝트 구조

## File Tree

```
└── ProjectManager
    └── App
        ├── AppDelegate.swift
        ├── SceneDelegate.swift
        ├── Resource
        │   ├── Assets.xcassets
        │   └── LaunchScreen.storyboard
        └── Source
            ├── Util
            │   └── Extension
            │       ├── Array+subscript.swift
            │       ├── DateFormatter+Deadline.swift
            │       └── UICollectionViewCell+IdentifierType.swift
            ├── Model
            │   ├── MyTask.swift
            │   ├── TaskManager.swift
            │   └── TaskState.swift
            ├── Main
            │   └── MainViewController.swift
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
            └── TaskForm
                ├── Extension
                │   ├── UITextField+publisher.swift
                │   └── UITextView+publisher.swift
                ├── TaskFormViewController.swift
                └── TaskFormViewModel.swift
```

</br>

# 📱 실행 화면

| **프로젝트 생성** | **프로젝트 편집** | 
| :---: | :---: |
| <img src="https://hackmd.io/_uploads/HJ8Jd5pB2.gif" width=400> | <img src="https://hackmd.io/_uploads/Hk4eF9TB2.gif" width=400>    | 

| **프로젝트 이동** | **프로젝트 삭제** |
| :---: | :---: |
| <img src="https://hackmd.io/_uploads/HJfQF9pSn.gif" width=400> | <img src="https://hackmd.io/_uploads/BJqrFqaS2.gif" width=400> |

</br>

# 🚀 트러블 슈팅

## 1️⃣ 작업 추가/수정 화면에서 완료 버튼의 활성/비활성화

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

## 2️⃣ 배열의 인덱스에 안전하게 접근하기
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

# 📚 참고 링크

* [Apple Docs - Combine](https://developer.apple.com/documentation/combine)
* [Apple Docs - UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
* [Apple Docs - UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
* [Apple Docs - popover(isPresented:attachmentAnchor:arrowEdge:content:)](https://developer.apple.com/documentation/swiftui/view/popover(ispresented:attachmentanchor:arrowedge:content:))
* [Apple Docs - intrinsicContentSize](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs - NotificationCenter.Publisher](https://developer.apple.com/documentation/foundation/notificationcenter/publisher)
* [github - A simple SwiftUI weather app using MVVM](https://github.com/niazoff/Weather)
