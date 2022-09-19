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
│   │   │   ├── Coordinator
│   │   │   │   └── TodoListCoordinator
│   │   │   ├── ViewModel
│   │   │   │   ├── HeaderViewModel
│   │   │   │   ├── ListCollectionViewModel
│   │   │   │   └── ListCellViewModel
│   │   │   └── View
│   │   │       ├── TodoListViewController
│   │   │       └── ListView
│   │   │           ├── Header
│   │   │           │   └── HeaderView
│   │   │           └── CollectionView
│   │   │               ├── ListCollectionView
│   │   │               ├── ListCollectionView+UIGestureRecognizerDelegate
│   │   │               └── Cell
│   │   │                   └── ListCell
│   │   ├── ModalTransitionScene
│   │   │   ├── Coordinator
│   │   │   │   └── FormSheetViewCoordinator
│   │   │   └── View
│   │   │       ├── FormSheetViewController
│   │   │       └── Template
│   │   │           └── FormSheetTemplateView
│   │   ├── PopoverScene
│   │   │   ├── Coordinator
│   │   │   │   └── PopoverViewCoordinator
│   │   │   ├── ViewModel
│   │   │   │   └── PopoverViewModel
│   │   │   └── View
│   │   │       └── PopoverViewController
│   │   ├── Model
│   │   │   ├── TodoModel
│   │   │   └── Category
│   │   ├── DataStore
│   │   │   ├── Todo
│   │   │   ├── TodoDataManager
│   │   │   └── Observable
│   │   ├── Assets
│   │   ├── LaunchScreen
│   │   └── Info
│   ├── Products
│   ├── Pods
│   └── Frameworks
└── Pods
```

## Coordinator
![](https://i.imgur.com/1hf3BAG.png)

## 화면구성
![](https://i.imgur.com/aYpgYgB.png)

## 데이터 구성
### TodoListViewController( 메인 뷰컨트롤러 )

![](https://i.imgur.com/kY1BK2D.png)


### Model
```swift

class Todo: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var category: String = Category.todo
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var date: Date = Date()
}

```

### ViewModel
HeaderViewModel , ListCollectionViewModel, ListCellViewModel, PopoverViewModel

### TodoDataManager
싱글톤 패턴으로 만들어, 각 뷰모델에서의 액션으로 인해 각 카테고리별 배열이 변경되었을 때 특정 클로저s 실행을 위해 Observable 클래스를 만들어 사용.
```swift
class Observable<T> {
    var value: T? {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listeners: [((T?) -> Void)] = []
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
```

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
    - 해당 리스트의 현재 셀 개수를 HeaderView.count에 동적 표현
- ListCell
    - 날짜가 지나면 dateLabel의 색을 빨간색으로 변경
    - 제목이 길면 끝에 ...으로 표현
    - 본문은 최대 3줄까지만 표현

## ⚒🛠Trouble Shooting

### 1. ViewModel 에서 UIKit 제거하기

ViewModel의 view transition 파트에서 파라미터로 CGPoint를 받아오는 부분 때문에 import UIKit이 되어있었다. 불필요한 부분이라 상위함수에서 전달해줄 때, CGPoint의 형태를 (Double, Double) 튜플형태로 전달 해주었다.
[근거](https://dev200ok.blogspot.com/2021/07/006-float-double-cgfloat.html)
> 추가적으로 Swift 5.5 버젼 이상에서는 CGFloat과 Double이 교환 가능하다고 합니다.

### 2. 클로져에서 [weak self] 캡쳐

습관적으로 클로저 사용 시, [weak self] 를 이용하여 캡쳐리스트를 가져왔는데, 리뷰어분의 질문에 의해 서칭을 한번 해보았다. 좋은 외국 아티클을 찾아 읽어보고 번역하며 내용을 이해해보았다.  [아티클 내용번역](https://hackmd.io/@gFY3eCCiRRKejwfOqnNr2g/BJCnWFbWj)

[weak self] 캡쳐를 해서 self를 사용하려면 optional binding을 해주거나 optional chaining 을 이용해야 하는데, 이 둘의 차이점에 대한 설명이 나와있었다. 

첫번째로, `guard let self = self else {return}` 구문이다. 이렇게 옵셔널 해제를 시켜주면 self가 클로저 scope동안 일시적인 강한참조를 유지하게 된다. 그래서 만약 self(=viewController로 생각해보면) 가 클로저 실행 중간에 dismiss가 된 상황을 생각 해보았을 때, 해제가 되지 않고 클로저 구문이 다 실행된 후에 할당해제가 될 것이다. delayed deallocated 가 되는것이다. 이는 나의 의도에 따라 좋을수도, 나쁠수도있다.

두번째로, `self?.` 옵셔널 체이닝을 이용해 접근하는 것이다. 이 방법으로 self에 접근한다면 위에 말했던 것 처럼 클로저 실행 중간에 self가 dismiss가 된 상황을 생각해보면, 그 시점 이후에 클로저 내부 나머지 코드 중 self로 접근하는 메서드들이 있으면 nil check에서 모두 건너뛰어 질 것이다. 할당해제가 바로 되는 것이다. 이 또한 나의 의도가 어떤지에 따라 좋을수도 나쁠수도 있다. 필요에 따라 두가지 방법을 적절히 사용하는 것이 좋을 것 같다 

아직 나머지 읽지 못한 부분이 있어 다 읽어본 후 내용이 추가 될 것이다.


### 3. 클로져로 데이터 바인딩

뷰 모델이 가지고 있는 클로저 프로퍼티를 어느 뷰에서 바인딩을 할 때, viewModel은 하나이지만 viewModel이 처리해주어야 하는 ListView 는 3개나 된다. 재활용 되는 ListView 한 곳에서 처리해주면 되겠지 싶어 그 안에 바인딩을 해주었는데 왠걸, doneListView에만 바인딩이 되는 것이다..ㅎ 이유는 아마 모두 같은 적용이 되었을 텐데 todoListView, doingListView, doneListView 순서대로 생성을 해주어 마지막에 생성된 doneListView에서 바인딩시켜준 didChangedCount() 가 최종적으로 할당이 된 것이라 생각이 된다.
예시:
``` swift
var number: Int?
number = 1
number = 2
number = 3

//최종은 3이 할당됨
```

**해결방법** : 3개의 ListView를 모두 가지고 있는 ViewController에서 바인딩을 해 주었다. 
**수정** : 위처럼 해결하니 디미터법칙을 위반하게 되었다. 하여 직접 ListCollectionView 에서 바인딩을 해주는데, 할당이 아닌 배열에 추가해주는 방식으로 변경을 하여 3 객체 모두 등록이 되도록 만들었다. 그래서 뷰모델에서도 클로저타입 프로퍼티가 아닌, 클로저배열타입 프로퍼티로 변경해주었다.
```swift
var didChangedCount: [(() -> Void)] = []
var didCreatedTodo: ((Todo) -> Void)?
var didEditedTodo: [(([Todo]) -> Void)] = []
var didMovedTodo: [(() -> Void)] = []
```

실행 시:
```swift
// in function

didMovedTodo.forEach { $0() }
didChangedCount.forEach { $0() }
```

### 4. 키보드가 텍스트뷰를 가림

실기기에서 테스트 결과, 할일의 내용을 작성하는 textView에서 키보드가 textView를 가려 내용이 보이지 않았다. 이 오류해결을 위해 먼저, formSheet 뷰를 scroll뷰로 한번 감싼 뒤, 키보드가 올라와 가리는 높이 만큼 bottomInset을 주어서 작성중인 내용이 가려지지 않도록 구현.



## 참고 링크
[Apple Article: Displaying transient content in a popover](https://developer.apple.com/documentation/uikit/windows_and_screens/displaying_transient_content_in_a_popover)
[LongTouchGestureRecognizer사용법](http://yoonbumtae.com/?p=4418)
[스크롤 시, 네비게이션 바 자동 숨김처리 비활성화](https://nemecek.be/blog/126/how-to-disable-automatic-transparent-navbar-in-ios-15)
[UIView그림자 만들기](https://babbab2.tistory.com/41)
[키보드가 텍스트뷰를 가릴때, 해결방법](https://seizze.github.io/2019/11/17/iOS에서-키보드에-동적인-스크롤뷰-만들기.html)
