# 프로젝트 관리 앱 

## 🙋🏻‍♂️ 프로젝트 소개
- MVVM 패턴을 적용하여 Data-Driven-Programming 구현

> 프로젝트 기간: 2022-09-05 ~ 2022-09-16
> 팀원: [브래드](https://github.com/bradheo65), [바드](https://github.com/bar-d) 
리뷰어: [토니](https://github.com/Monsteel)


## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [📦 파일 구조](#-파일-구조)
- [📱 동작 화면](#-동작-화면)
- [💡 키워드](#-키워드)
- [📚 참고문서](#-참고문서)
- [📝 기능설명](#-기능설명)
- [🚀 TroubleShooting](#-TroubleShooting)
    - [🚀 STEP 1](#-STEP-1)

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[브래드](https://github.com/bradheo65)|[바드](https://github.com/bar-d)| 
|:---:|:---:|
| <img src = "https://user-images.githubusercontent.com/45350356/174251611-46adf61c-93fa-42a0-815b-2c998af1c258.png" width="250" height="250">| <img src = "https://i.imgur.com/wXKAg8F.jpg"  width="250" height="250">|


## 📦 파일 구조

```
.
├── Extentsion
│   ├── Array+Extension.swift
│   ├── Date+Extension.swift
│   ├── JSONDecoder+Extentsion.swift
│   └── UILabel+Extension.swift
├── Protocol
│   ├── DataManagable.swift
│   ├── DataSenable.swift
│   ├── Presentable.swift
│   └── ReuseIdentifiable.swift
├── Resources
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   └── Contents.json
│   ├── Info.plist
│   ├── LaunchScreen.storyboard
│   └── SceneDelegate.swift
└── Scene
    └── Main
        ├── Model
        │   ├── ItemListCatory.swift
        │   ├── MockData.json
        │   └── MockToDoItemManager.swift
        └── View
            ├── Common
            │   ├── ProjectType.swift
            │   └── ToDoComponentsView.swift
            ├── MainView
            │   ├── MainViewController.swift
            │   ├── MainViewModel.swift
            │   └── ProjectTableView
            │       ├── ProjectDetailViewController.swift
            │       ├── ProjectTableHeaderView.swift
            │       ├── ProjectTableView.swift
            │       └── ProjectTableViewCell.swift
            └── RegistrationView
                └── RegistrationViewController.swift
```


## 📱 동작 화면

|새 프로젝트 등록|프로젝트 수정|
|:---:|:---:|
|<image src = "https://i.imgur.com/9ZCPNtP.gif" >|<image src = "https://i.imgur.com/OTlllvG.gif">|
|테이블 뷰 간의 이동|스와이프 삭제|
|<image src = "https://i.imgur.com/SBHEauJ.gif" >|<image src = "https://i.imgur.com/WeBlTJH.gif">|

## 💡 키워드
- MVVM
- ViewModel
- DataBinding
- JSON
- UITableView
- UITextView
- UIPopoverPresentationController
- UILongPressGestureRecognizer
- UIViewController.modalPresentationStyle
- Delegate

    
## 📚 참고문서
- [Pickers](https://developer.apple.com/design/human-interface-guidelines/ios/controls/pickers/)
- [DatePicker](https://developer.apple.com/documentation/swiftui/datepicker)
- [Compare iOS Databases](https://realm.io/best-ios-database/#overview)
- [DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)
- [Handling Notifications and Notification-Related Actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)
- [UndoManager](https://developer.apple.com/documentation/foundation/undomanager)
- [Scheduling a Notification Locally from Your App](https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app)
- [Localizations](https://developer.apple.com/kr/localization/)

  
## 📝 기능설명
- 작성한 할 일의 목록을 보여주는 Table View 구현
- UITextField, UIDatePicker ,UITextView를 활용하여 할 일 작성기능 구현
- MVVM을 통한 Model View ViewModel 구현 
- UITableView Swipe
- UILongPressGestureRecognizer를 통한 UIAlertControler 구현
    
## 🚀 TroubleShooting
    
### 🚀 STEP 1

#### T1. ViewControoler present   

![](https://i.imgur.com/GAo1YG3.png)    
    
- 처음 구현해 주었던 뷰 컨트롤러는 세개의 뷰 컨트롤러를 가지고 있고 각 뷰 컨트롤러에 테이블 뷰를 가지고 있는 형식으로 구현을 해줌
- 최상위 뷰 컨트롤러에서 네비게이션 컨트롤러를 인스턴스화하여 `present(:animated)`메소드를 사용해주었더니 아래와 같은 워닝 발생
    ![](https://i.imgur.com/Jvqdbwd.png)  
    구글링을 통해 윈도우에 접근하여 직접 rootViewController에서 present를 해주었더니 에러 메세지가 사라졌지만, rootViewController에 직접 접근하는 방식이 좋지 않다고 생각함
-  뷰 컨트롤러가 각자 분리되어있지 않고 하나의 뷰 컨트롤러 내부에 여러개의 뷰 컨트롤러가 들어가 있어서 child를 설정해 주지 않아 발생한 문제
- 최상위 뷰 컨트롤러에게 하위 세개의 뷰 컨트롤러를 최상위 뷰 컨트롤러의 child로 설정해주고
  `present(:animated)`메소드를 사용하였더니 해당 워닝이 사라짐

#### T2. StackView Constraints
![](https://i.imgur.com/TxmWYIs.png)  
![](https://i.imgur.com/KQdNP0R.png)
- UILabel 두 개를 스택뷰에 `addArrangedSubview()` 메서드를 통해 넣어주고 `indexLabel`을 정사각형으로 만들어주기 위해 `indexLabel`의 width를 `indexLabel`의 `height｀에 맞추어줌
- View Hierarchy에서 스택 뷰 내부의 뷰의 프레임을 보면 프레임이 잘 잡혀있고 뷰 자체는 잘 나오지만,   
    실제로 해당 뷰의 프레임을 프린트해보면 0으로 나오는 것을 확인
- 스택뷰에 `addArrangedSubview()`로 해당 레이블들을 넣어주면서 스택뷰의 특성상 `alignment`와 `distribution`을 잡아주지 않아도 기본 값으로 `.fill`이 들어가져 있어서 `indexLabel`의 제약과 충돌
- 원형 레이블을 그려주기 위해 스택뷰를 뷰로 대체해주고, 각각의 뷰에 대한 제약을 걸어줌

#### T3. MVVM - VM(Data Binding)

이스케이핑 클로저를 통해 저장 프로퍼티 바인딩 클로저 등록 에러

|문제 코드|
|:---:|
|<img src = "https://i.imgur.com/R2qOZDa.png">|
|해결 코드|
|<img src = "https://i.imgur.com/X4dFwpS.png">|
    
- 데이터 바인딩이 각 프로퍼티 옵저버가 발생되는 것이 아닌 한개의 프로퍼티 옵저버 `todoContent` 발생함
- 문제 발생에 대해서 생각해보니 해당 매개변수가 `클로저`이기에 계속해서 하나의 값만 가지고 있어 발생된 문제
- 해결 방법으로는 이스케이핑 클로저 함수를 만들어주고 각 프로퍼티마다 설정을 해줘서 해결해줌
