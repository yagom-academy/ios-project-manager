# 📁 Project Manager

###### tags: `README`

## 개요

할 일 목록을 **TODO**, **DOING**, **DONE** 세 가지 카테고리로 나누어 유연하게 관리해주는 앱.

## 기술스택
| Dependency | UI | Design Pattern |
|:---:|:---:|:---:|
|Realm, FireBase, SwiftLint|UIKit|MVVM + Coordinator|

## File Tree
```
.
├── ProjectManager
│   ├── swiftlint
│   ├── ProjectManager
│   │   ├── Protocol
│   │   │   └── Coordinator
│   │   ├── Extensions
│   │   │   ├── UITextField+Extension
│   │   │   └── TimeInterval+Extension
│   │   ├── Application
│   │   │   ├── AppDelegate
│   │   │   ├── AppAppearance
│   │   │   └── AppCoordinator
│   │   ├── MainScene
│   │   │   ├── ViewModel
│   │   │   │   └── TodoListViewModel
│   │   │   └── View
│   │   │       ├── TodoListViewController
│   │   │       └── ListView
│   │   │           ├── Header
│   │   │           │   └── HeaderView
│   │   │           └── CollectionView
│   │   │               ├── ListCollectionView
│   │   │               └── Cell
│   │   │                   └── ListCell
│   │   ├── ModalTransitionScene
│   │   │   └── View
│   │   │       ├── CreateTodoListViewController
│   │   │       ├── EditTodoListViewController
│   │   │       └── Template
│   │   │           └── FormSheetTemplateView
│   │   ├── PopoverScene
│   │   │   ├── ViewModel
│   │   │   │   └── PopoverViewModel
│   │   │   └── View
│   │   │       └── PopoverViewController
│   │   ├── Model
│   │   │   ├── TodoModel
│   │   │   └── Category
│   │   ├── mockData
│   │   ├── Assets
│   │   ├── LaunchScreen
│   │   └── Info
│   ├── Products
│   ├── Pods
│   └── Frameworks
└── Pods
```
## 화면구성
![](https://i.imgur.com/aYpgYgB.png)

## 기능구현

### - AppCoordinator
- 뷰 전환을 AppCoordinator에서 관리 하도록 구현
- 각 ViewController 에 
```swift
static func create(with: ViewModel, coordinator: Coordinator) -> UIViewController
``` 
위와 같은 형태의 메서드를 이용하여 ViewController를 생성할 때, ViewModel과 Coordinator 를 주입

### - 할 일 추가
- "TodoListViewController" 에서 네비게이션 바의 우측상단 "+" 버튼을 누르면 modalTransitionStyle 이 .formSheet 형태로 입력양식을 띄움
    - 입력 양식에서 우측상단의 Done 버튼 탭시, 입력된 데이터를 저장 후 셀 생성
    - 입력 양식에서 좌측상단의 Cancel 버튼 탭시, 취소
- 이 루트를 통해 생성되는 셀은 모두 TODO List 로 추가 되도록 설정

<img src="https://i.imgur.com/Yu97jAJ.gif" width=500>

### - 할 일 삭제
- 해당 셀 trailing Swipe시, 삭제버튼이 나오도록 구현
    - 나타난 delete 버튼 탭시 셀 삭제
- 해당 셀 trailing Swipe를 끝까지할 시, 삭제
    
<img src="https://i.imgur.com/3ijJ8ux.gif" width=500>

### - 할 일 수정
- 특정 셀 탭시, modalTransitionStyle이 .formSheet 형태로 입력양식을 띄움
    - 입력 양식에는 해당 셀의 세부정보가 채워진다
    - 입력 양식에서 내용을 수정한 뒤, 좌측상단의 Edit 버튼 탭시 셀 정보 수정
    - 입력 양식에서 Done 버튼 탭시, 뒤로가기 (수정사항 반영 x)

<img src="https://i.imgur.com/vcFUzng.gif" width=500>

### - 할 일 이동
- 특정 리스트 내에서 LongTouch를 할 시, 나머지 리스트로 이동할 수 있는 modalTransitionStyle이 .popover인 양식 띄움.
- 두 버튼에 어느 리스트로 이동 할 것인지 표현, 버튼 탭시 해당 리스트로 셀을 이동.

<img src="https://i.imgur.com/58NYrYN.gif" width=500>

### - 기타
- HeaderView
    - 해당 리스트의 현재 셀 개수를 HeaderView.count에 표현
- ListCell
    - 날짜가 지나면 dateLabel의 색을 빨간색으로 변경
    - 제목이 길면 끝에 ...으로 표현
    - 본문은 최대 3줄까지만 표현

## ⚒🛠Trouble Shooting

### 1. ViewModel 에서 UIKit 제거하기

ViewModel의 view transition 파트에서 파라미터로 CGPoint를 받아오는 부분 때문에 import UIKit이 되어있었다. 불필요한 부분이라 상위함수에서 전달해줄 때, CGPoint의 형태를 (Double, Double) 튜플형태로 전달 해주었다.
[근거](https://dev200ok.blogspot.com/2021/07/006-float-double-cgfloat.html)
> 추가적으로 Swift 5.5 버젼 이상에서는 CGFloat과 Double이 교환 가능하다고 합니다.

## 참고 링크
[Apple Article: Displaying transient content in a popover](https://developer.apple.com/documentation/uikit/windows_and_screens/displaying_transient_content_in_a_popover)
[LongTouchGestureRecognizer사용법](http://yoonbumtae.com/?p=4418)
[스크롤 시, 네비게이션 바 자동 숨김처리 비활성화](https://nemecek.be/blog/126/how-to-disable-automatic-transparent-navbar-in-ios-15)
[UIView그림자 만들기](https://babbab2.tistory.com/41)
