# 프로젝트 관리 앱

## 프로젝트 소개
프로젝트 관련 일정을 관리할 수 있는 앱을 제작하는 프로젝트

> 프로젝트 기간: 2022-09-05 ~ 2022-09-16</br>
> 팀원: [Finnn](https://github.com/finnn1) </br>
리뷰어: [Wody](https://github.com/Wody95)</br>


## 📑 목차

- [⏱ TimeLine](#-TimeLine)
- [💡 키워드](#-키워드)
- [🤔 핵심경험](#-핵심경험)
- [🗂 폴더 구조](#-폴더-구조)
- [📝 기능설명](#-기능설명)
- [🚀 TroubleShooting](#-TroubleShooting)
- [📚 참고문서](#-참고문서)

## ⏱ TimeLine

### Week 1
    
> 2022.09.05 ~ 2022.09.09
    
- 2022.09.05
    - STEP1 명세 확인
    - 기술 스택 조사

- 2022.09.06 
    - 기술 스택 선정
    - SwiftLint 설치 및 세팅
    - STEP1 PR
    
- 2022.09.07
    - RxSwift, MVVM 공부

- 2022.09.08
    - RxSwift, MVVM 공부
    - SwiftLint 규칙 재설정
    - 기본적인 UI구현

- 2022.09.09
    - Mock Data를 활용해 ViewModel 구현
    - RxSwift로 ViewModel과 View 연동
    
### Week 2

> 2022.09.12 ~ 2022.09.13
    
- 2022.09.12
    - Firebase 설치 및 세팅
    - Todo 데이터 Save 기능 구현
    - Todo 데이터 Delete 기능 구현
    - Todo 데이터 Status 변경 기능 구현
    - 전반적인 코드 리팩토링 및 정리
    
- 2022.09.13
    - 전반적인 코드 리팩토링 및 정리
    - Step3 PR 작성

- 2022.09.14
    - Step3 PR 작성
    
## 🤔 핵심경험

- [x] 다양한 기술 중 목적에 맞는 기술선택
- [x] 내가 선택한 기술을 통한 UI구현
- [x] Word wrapping 방식의 이해
- [x] 리스트에서 스와이프를 통한 삭제 구현
- [x] Date Picker를 통한 날짜입력

## 🗂 폴더 구조

```
.
├── ProjectManager
│   ├── ProjectManager
│   │   ├── App
│   │   │   ├── AppDelegate.swift
│   │   │   ├── Assets.xcassets
│   │   │   │   ├── AccentColor.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── AppIcon.appiconset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   ├── Base.lproj
│   │   │   │   └── LaunchScreen.storyboard
│   │   │   ├── GoogleService-Info.plist
│   │   │   ├── Info.plist
│   │   │   └── SceneDelegate.swift
│   │   ├── Enum
│   │   │   ├── Error
│   │   │   │   └── TodoError.swift
│   │   │   └── TodoStatus.swift
│   │   ├── Extension
│   │   │   └── Date+Extension.swift
│   │   ├── FirebaseManager
│   │   │   └── FirebaseManager.swift
│   │   ├── Model
│   │   │   └── Todo.swift
│   │   ├── View
│   │   │   ├── ProjectManagerCollectionViewCell.swift
│   │   │   ├── ProjectManagerViewController.swift
│   │   │   ├── SectionHeaderView
│   │   │   │   └── TableSectionHeaderView.swift
│   │   │   ├── TodoDetailView
│   │   │   │   └── TodoDetailViewController.swift
│   │   │   └── TodoListTableViewCell.swift
│   │   └── ViewModel
│   │       └── ProjectManagerViewModel.swift
│   └── ProjectManager.xcodeproj
│       ├── project.pbxproj
│       ├── project.xcworkspace
│       │   ├── contents.xcworkspacedata
│       │   ├── xcshareddata
│       │   │   ├── IDEWorkspaceChecks.plist
│       │   │   └── swiftpm
│       │   │       └── Package.resolved
│       │   └── xcuserdata
│       │       └── leechiheon.xcuserdatad
│       │           └── UserInterfaceState.xcuserstate
│       ├── xcshareddata
│       │   └── xcschemes
│       │       └── ProjectManager.xcscheme
│       └── xcuserdata
│           └── leechiheon.xcuserdatad
│               ├── xcdebugger
│               │   └── Breakpoints_v2.xcbkptlist
│               └── xcschemes
│                   └── xcschememanagement.plist
└── README.md
```
    
## 📝 기능설명

### STEP 1
    
**기술 스택 선정**

#### 프로젝트 적용기술 선정
|View|Architecture|Asynchronous|Network|LocalDB|RemoteDB|
|:---:|:---:|:---:|:---:|:---:|:---:|
|<img src="https://i.imgur.com/P3mQATF.png" alt="drawing" width="100"/>|<img src="https://i.imgur.com/TqZH0ZJ.png" alt="drawing" width="100"/>|<img src="https://i.imgur.com/mZMyv10.png" alt="drawing" width="100"/>|<img src="https://i.imgur.com/7je4Ay4.png" alt="drawing" width="100"/>|<img src="https://i.imgur.com/o0vsyYL.png" alt="drawing" width="100"/>|<img src="https://i.imgur.com/lHZhC6Z.png" alt="drawing" width="100"/>|
|`UIKit`|`MVVM`|`RxSwift`|`URLSession`|`CoreData`|`FireBase`|

## View Drawing - UIKit
> 처음에 `SwiftUI`을 고민했었지만 아직 `UIKit`에 대해서도 많이 알고 있지 못하다는 생각이 들어 배우고 있었던 것에 조금 더 집중하고자 `UIKit`을 선택했습니다.
## Architecture - MVVM
> 평소 `Cocoa MVC` 패턴으로만 써왔었기 때문에 이번 프로젝트에서는 `MVVM` 아키텍쳐 패턴을 배우는 것에 초점을 두고자 `MVVM`으로 프로젝트를 진행해볼 예정입니다.
## Asynchronous - RxSwift
> 리뷰어 `Wody`의 추천으로 이번 프로젝트에서는 `RxSwift`를 사용해 비동기 처리를 하는 것으로 결정했습니다. ☺️
## Network - URLSession
> 네트워크 관련 여러가지 라이브러리 (`Alamofire`, `Moya` 등..)이 있다고 들었지만, 내부 구현은 `URLSession`으로 구현이 되어있기 때문에 기본에 충실하고자 `URLSession`을 사용하여 프로젝트를 진행하려고 합니다.
## DataBase - CoreData, FireBase
> **LocalDB - CoreData**
> 아직 `CoreData`를 다 익히지 못했기 때문에 `CoreData`를 더 익히고, `MVVM` 패턴을 배우는 것에 집중하기 위해서 `CoreData`를 선택했습니다.
> **RemoteDB - FireBase**
> `iCloud`는 개발자개정(유료)가 있어야 하고, `Dropbox`는 개발용 DB로써 적합한지에 관한 의문이 들어 `Google`에서 운영하고 유연성이 좋은 `FireBase`를 선택했습니다.

---

</br>

## 고민 포인트

### 하위 버전 호환성에는 문제가 없는가?
> `CoreData` - `iOS 8+`
> `FireBase` - `iOS 10+`
### 안정적으로 운용 가능한가?, 미래 지속가능성이 있는가?
> `CoreData`은 `Apple`, `FireBase`는 `Google`에서 운영하고 있는 서비스이기 때문에 미래 지속성 및 안정적인 운영이 가능하다고 생각했습니다. ☺️
### 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
#### CoreData
> 다른 `LocalDB`에 비해 빠른 속도를 자랑하지만, 그 만큼 메모리 및 저장공간을 차지한다고 알고 있습니다. 다만, 사용자 경험 측면에서 빠른 속도가 더욱 중요하다고 생각하기 때문에 `CoreData`를 선택했습니다. ☺️
#### Firebase
> 서버가 해외에 있어 서버와의 지연이 발생할 수 있다고 합니다. 다만, 다양한 기능 및 데이터가 들어있는 대규모 프로젝트가 아닌 현재의 프로젝트에서는 아직까진 괜찮다고 생각합니다. 😅 추후, 프로젝트의 규모가 커진다거나 데이터의 양이 많아진다면 다시 고려해봐야 할 것 같습니다.
### 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
> `Apple`에서 직접 제공하는 `Swift Package Manager`를 사용해서 `FireBase`를 운영 가능합니다. 다만, 이번 프로젝트 요구사항인 `SwiftLint`의 경우는 아직 `Swift Package Manager`를 지원하지 않기 때문에 `CocoaPod`을 사용할 것 같습니다.
    
### STEP 2

|**새로운 Todo 저장**|
|:---:|
|![](https://i.imgur.com/DbLyQbX.gif)|
|**Todo 상세내용 수정**|
|![](https://i.imgur.com/cpif8vz.gif)|
|**Todo 상태 변경**|
|![](https://i.imgur.com/Wrsk8k6.gif)|
|**Todo 삭제**|
|![](https://i.imgur.com/HMUDIbl.gif)|

## 🚀 TroubleShooting

### STEP 2
#### T1. `ViewModel`에서 `Error` 발생시 처리 방법에 관한 고민
- `ViewModel`에서 에러가 발생할 경우 `ViewController`에서 해당 `Error`를 사용자에게 알려줄 필요가 있었습니다.
- `ViewModel`은 `View`를 몰라야 한다고 생각했기 때문에 `Error`를 `Observable` 객체로 만들어 `View`에서 해당 객체를 `subscribe` 하는 방식으로 에러를 처리했습니다.
- `Error`가 발생할 경우 `onNext` 메서드로 해당 에러를 전달하면, `View` 쪽에서 해당 `Error`를 `present` 해주는 방식으로 처리했습니다.

**ViewModel:**
```swift
class ProjectManagerViewModel {
    var alertError = PublishSubject<Error>()

    ...
    
    // 에러 발생시
    alertError.onNext(error)
}
```
**ViewController:**
```swift
viewModel.alertError
    .subscribe(onNext: { error in
        present(error)
    })
```
#### T2. `UITextView`에 `clipToBound`를 `false` 하는 경우 텍스트가 `bound`를 벗어나는 현상
- 초반에는 `UITextView`에 그림자를 주기 위해서 `clipToBound`를 `false`로 변경했습니다.
- 이렇게 하면 `UITextView`에 그림자를 설정해 줄 경우 그림자는 잘 들어갔지만, 장문의 텍스트를 입력했을 때 텍스트가 `TextView`의 `Bound`를 벗어나는 현상이 발생했습니다.
- 고민 끝에 `UITextView`의 `clipToBound`는 `true`로 설정해주고, 별도의 그림자 전용 `UIView`를 생성해서 `UITextView`와 레이아웃을 동일하게 맞춰준 후, 해당 `UIView`에 그림자를 설정해주는 방식으로 진행했습니다.
```swift
// UITextView
private let bodyTextView: UITextView = {
    let textView = UITextView()
    return textView
}()

// 그림자용 View
private lazy var bodyTextShadowView: UIView = {
    let view = UIView(frame: bodyTextView.frame)
    view.backgroundColor = .white

    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.systemGray6.cgColor

    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = 3.0
    view.layer.shadowOffset = CGSize(
        width: 3,
        height: 3
    )
    view.layer.shadowColor = UIColor.gray.cgColor
    return view
}()

// 그림자용 View의 레이아웃을 UITextView와 동일하도록 설정
bodyTextShadowView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        bodyTextShadowView.topAnchor.constraint(equalTo: bodyTextView.topAnchor),
        bodyTextShadowView.bottomAnchor.constraint(equalTo: bodyTextView.bottomAnchor),
        bodyTextShadowView.leadingAnchor.constraint(equalTo: bodyTextView.leadingAnchor),
        bodyTextShadowView.trailingAnchor.constraint(equalTo: bodyTextView.trailingAnchor)
    ])
```
    
--- 
    
## 2️⃣ STEP 2

### STEP 2 Questions & Answers

#### Q1. 전반적인 코드 구조에 관한 질문
- 이번에 `MVVM` 패턴과 `RxSwift`를 처음 사용해보면서 컨벤션 및 전체적인 코드가 깔끔하지 못하다는 느낌을 많이 받았습니다...
- 제가 짠 코드가 `MVVM` 패턴은 맞는지, `RxSwift`를 잘 사용한 것인지 감이 오질 않습니다 😭
- 질문이 추상적이서 죄송하지만 전반적인 구조에 관해 부족한 부분을 피드백 주시면 감사하겠습니다... 🙇‍♂️

#### Q2. `onComplete` 후 `Observable` 객체의 재사용 방법
- 데이터를 저장 할 때, `Title`이 비어있는 경우 저장하는 창을 `dismiss` 해주지 않고 `alert`를 띄우기 위해서 서버 쪽에서 저장이 완료될 경우 `onComplete`를 호출하도록 해서 데이터 저장 작업이 완료된 것을 확인한 후 `dismiss`를 해주고 있습니다.
<img src="https://i.imgur.com/kRpcVkt.png" alt="drawing" width="500"/>
</br>
- 다만, `onComplete`를 호출할 경우 `subscribe` 해놨던 `Observable` 객체를 더 이상 재사용하지 못하는 문제가 발생했습니다.
- 때문에 `onComplete`를 한 후, `Observable` 객체를 한번 더 생성해주는 것으로 문제를 해결했습니다.
- 하지만 매번 이렇게 `onComplete` 후 `Observable` 객체를 다시 생성해주는 것이 비효율적이라는 생각이 들었습니다.
- 다른 방법이 있는지 찾아봤지만 제 능력 부족으로 찾지 못해서 혹시 다른 좋은 방법이 있는지 궁금합니다... 🥲
#### 저장하는 쪽의 코드 (`ProjectManagerViewModel.swift`)
```swift
private func requestSave(using todoData: Todo) {
    FirebaseManager.shared.sendData(
        collection: ProjectManagerViewModel.firestoreCollectionName,
        document: todoData.todoId.uuidString,
        data: todoData
    )
    .take(1)
    .subscribe(onError: { error in
        self.alertError.onNext(error)
    }, onCompleted: {
        
        // ⬇️ saveTodoData를 onComplete한 후, Observable 객체를 재생성 해주고 있습니다.
        self.saveTodoData?.onCompleted()
        
        self.saveTodoData = PublishSubject<Todo>()
        self.saveTodoData?
            .subscribe(onNext: { todoData in
                self.requestSave(using: todoData)
            })
            .disposed(by: disposeBag)
        
    })
    .disposed(by: self.disposeBag)
}
```
#### 저장을 요청하는 쪽의 코드 (`TodoDetailViewController.swift`)
```swift
doneButton.rx.tap
    .subscribe(onNext: {
        guard let currentTodoInfo = self.getCurrentTodoInfomation() else { return }

        self.viewModel?.saveTodoData?.onNext(currentTodoInfo)
        // ⬇️ onCompleted가 호출된 경우에만 dismiss를 해주고 있습니다.
        self.viewModel?.saveTodoData?.subscribe(onCompleted: {
            self.dismiss(animated: true)
        })
        .disposed(by: self.disposeBag)
    })
    .disposed(by: disposeBag)
```


