# 프로젝트 관리 앱

## 프로젝트 소개
각각의 프로젝트를 관리하는 앱을 생성한다.

> 프로젝트 기간: 2022-09-05 ~ 2022-09-16</br>
> 팀원: [수꿍](https://github.com/Jeon-Minsu), [Hugh](https://github.com/Hugh-github) </br>
리뷰어: [Ryan](https://github.com/ryan-son)</br>


## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [⏱ TimeLine](#-TimeLine)
- [💡 키워드](#-키워드)
- [🛠 기술 스택](#-기술-스택)
- [📂 폴더 구조](#-폴더-구조)
- [📱 화면 구현](#-화면-구현)
- [📃 기능 설명](#-기능-설명)
- [🚀 TroubleShooting](#-TroubleShooting)
- [📚 참고문서](#-참고문서)

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|수꿍|휴|
|:---:|:---:|
|<image src = "https://i.imgur.com/6HkYdmp.png" width="250" height="250">|<image src = "https://i.imgur.com/5oaoHWd.png" width="250" height="250">|
|[수꿍](https://github.com/Jeon-Minsu)|[휴](https://github.com/Hugh-github)|

## ⏱ TimeLine

### Week 1
    
> 2022.09.05 ~ 2022.09.09
    
- 2022.09.05
    - 기술 스택 선정

- 2022.09.06 
    - STEP1 PR

- 2022.09.07
    - STEP2 하위 STEP 분리
        - 2-1 : CoreData 구현
        - 2-2 : 기본적인 화면 구현
        - 2-3 : MVVM 구현 및 테스트 작성
        - 2-4 : 최종 완성(View Event 처리 및 ViewModel과 연결)

- 2022.09.08
    - CollectionView를 이용해 화면 구현

- 2022.09.09
    - 추석 연휴
    
### Week 2
> 2022.09.11 ~ 2022.09.17
    
- 2022.09.11
    - 기본적인 화면 구현 완료
    - STEP 2-1, 2-2 PR
    
## 💡 키워드

- `UITableView`, `HeaderView`, `UIGraphicsImageRenderer`, `DatePicker`, `Core Data`, `SPM`, `firebase`
    
## 🛠 기술 스택
### target version
`iOS 14.0`, `iPadOS 14.0`

- iOS 14.0 이상을 사용하는 유저가 전체 유저의 99%를 차지하고 이번 프로젝트에서 async, await 및 sendAction을 통한 button 이벤트 테스트를 하기 위해 target version을 14.0으로 결정했습니다. 

|iOS|iPadOS|
|:---:|:---:|
|<image src = "https://i.imgur.com/MuDZgV0.png" width="200" height="300">|<image src = "https://i.imgur.com/SxroxGG.png" width="200" height="300">|

(출처: https://developer.apple.com/support/app-store/)

### UI
- UIKit
이번 프로젝트에서 MVVM과 테스트 코드에 비중을 두고 진행할 계획이기 때문에 UIKit만을 사용하여 데이터 바인딩을 직접 구현해보는 것이 라이브러리를 사용하기 전에 중요한 경험이 될 것이라고 생각했습니다.

### Architecture
- MVVM
MVC 아키텍처보다는 View를 다루는 로직에 대하여 테스트하기 용이하기 때문에 MVVM 아키텍처를 선택하였습니다.
기회가 된다면 clean architecture 와 coordinator를 적용해 볼 계획입니다.

### 동시성
- Swift Concurrency
이번 프로젝트에서는 rx보다 swift 5.5 이후에 등장한 async await을 이용해 프로젝트를 진행하기로 결정했습니다.
    
### database
- Local : CoreData
    Apple에서 제공하는 first party 기술을 먼저 익히고자 Core Data를 선택했습니다.
    또한, SQLite보다 속도가 빨라 더 만족스러운 UX를 제공할 수 있다고 생각했습니다.
- Remote : Firebase
    Firebase 같은 경우 iOS 10.0 이상부터 사용이 가능합니다.
    NoSQL기반 데이터베이스로 관계형 데이터베이스보다 빠르고 간편합니다.
    또한, 다른 데이터 베이스들과 다르게 RTSP(Real Time Stream Protocol) 방식의 데이터베이스를 지원하고 있기 때문에 소켓 기반 서버를 만들어서 통신하는 것 보다 훨씬 코드 양이 줄게되어 코드 몇 줄로도 원하는 구성을 만들 수 있습니다.

### 의존성 관리도구
- SPM(Swift Package Manager)

## 📂 폴더 구조
```
.
└── ProjectManager/
    ├── Model/
    │   └── ProjectUnit
    ├── View/
    │   ├── MainView/
    │   │   ├── ProjectManagerController
    │   │   ├── ProjectManagerListCell
    │   │   ├── SectionHeaderView
    │   │   └── ScheduleStackView
    │   └── AddView/
    │       ├── ProjectAdditionController
    │       └── ProjectAdditionScrollView
    └── Resource/
        ├── CoreData/
        │   ├── Project+CoreDataClass
        │   └── Project+CoreDataProperties
        └── Database/
            ├── DatabaseError
            ├── DatabaseLogic
            └── LocalDatabaseManager
```
    
## 📱 화면 구현

- TODO, DOING, DONE 화면을 각각 TableView를 이용해 구현
![](https://i.imgur.com/aw3o1ry.png)

- Modal의 formSheet 스타일로 AddView 구현
![](https://i.imgur.com/inAFoRU.png)

## 📃 기능 설명
    
- MainView
    - 3개의 Table View를 하나의 Custom StackView에 저장해 관리
    - Table View의 header로 사용할 Custom View 구현
    
- AddView
    - Modal Style 중 form sheet 사용
    - Date Picker를 사용해 날짜를 선택하는 View 구현
    - Text Field와 Text View에 shadow 효과 추가
    
## 🚀 TroubleShooting

### STEP 2-1
### STEP 2-2
    
## 📚 참고문서

- [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
    
--- 
    
## 2️⃣ STEP 2-1, 2-2

### STEP 2-2 Questions & Answers

#### Q1. Collection View의 Section 가로 배치 문제
- Collection View로 Section을 추가할 경우 세로 방향으로 추가되는 걸 확인했습니다. FlowLayout을 사용할 경우 scroll 방향을 horizontal로 해주면 가로 방향으로 추가되는 걸 확인할 수 있었지만 Section 별로 스크롤 방향을 주는 방법이 어려웠습니다. 
혹시 이번 프로젝트의 View를 구현할 때 어떠한 방법을 주로 사용하는지 궁금합니다. 
    
#### Q2. TextView Shadow 적용 문제
    
- UITextField의 경우에는 아래의 코드와 같이 layer에 shadow를 넣어주기만 하면 정상적으로 작동하였습니다.
    
```swift
private let scheduleTitleTextField: UITextField = {
        let textField = UITextField()
        ...
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowColor = UIColor.gray.cgColor
        
        return textField
}()
```
    
- 이와 달리, UITextView의 경우에는 위와 동일한 방법으로 layer에 shadow를 적용하였으나, shadow가 정상적으로 화면에 표시되지 않는 문제를 발견하였습니다. 이를 해결하기 위하여 처음에는 clipsToBounds 프로퍼티를 true로 설정하면, 정상적으로 shadow가 표시되나 TextView의 내용이 길어지면, 위에 있는 글자가 TextView를 벗어나는 에러를 발견하였습니다. 
- 현재는 이를 해결하기 위한 다른 방법으로 UIView를 하나 생성하여 shadow를 적용하고, 그 위에 TextView를 addSubview메서드를 통해 추가하였습니다.
- 별도의 UIView 생성 없이 TextView 자체에 shadow를 정상적으로 적용하기 위한 방법이 있을지 질문드리고 싶습니다.
- 추가로, UITextField와 UITextView의 차이가 아래의 View Hierarchy에서의 위치에서 비롯되는 것일지 의문이 듭니다.
- ![](https://i.imgur.com/ZOXcoL2.jpg)
