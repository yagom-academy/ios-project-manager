# 👨🏻‍💼 프로젝트 매니저
> 기간: 2022-09-05 ~ 2022-09-16
> 
> 팀원: [Kiwi](https://github.com/kiwi1023)
> 
> 리뷰어: [태태](https://github.com/uuu1101)
> 
## 📑 목차

- [💻 기술 스택 설명](#-최종-기술-스택)
- [📦 파일 구조](#-파일-구조)
- [📱 동작 화면](#-동작-화면)
- [💡 키워드](#-키워드)
- [🤔 핵심경험](#-핵심경험)
- [📚 참고문서](#-참고문서)
- [🚀 TroubleShooting](#-TroubleShooting)
    - [🚀 STEP 2](#-STEP-2)

## 최종 기술 스택 📱

|화면구현|비동기처리|LocalDB|RemoteDB|의존성관리도구|
|-|-|-|-|-|
|![](https://i.imgur.com/IRugLYJ.png)|![](https://i.imgur.com/erAvNzW.png)|![](https://i.imgur.com/pt7joDs.png)|![](https://i.imgur.com/JyJLmzh.png)|![](https://i.imgur.com/fHOfzWQ.png)

## 기술 스택 선정 이유 💻

### LocalDB

| |CoreData|
|-|-|
|특징| 1. Persistence 기능은 SQLite에 의해 지원됨 </br> 2. ORM 모델을 추상화한 구조 </br> 3. 앱의 Model layer를 관리하기 위한 Apple의 First-party FrameWork </br> 4. Object에 더 중심을 둠 
|장점|1. 데이터를 객체 (NSManagedObject) 형태로 저장하여 DB에서 가져온 데이터를 앱에 즉시 사용 가능</br>2. SQLite 대비 속도가 빠름</br>3. iOS에서 자체 제공하기 때문에 비교적 안정적임
|단점|1. Thread-unsafe</br>2. 오버헤드 발생 가능</br>3. Android 등 크로스 플랫폼을 지원하지 않음</br>4. SQLite보다 많은 메모리를 사용하고, 더 많은 저장공간이 필요
|선정이유| 라이브러리의 사용보다는 가장 기본적인 DB를 사용하고 싶었고, 러닝커브를 조금이라도 줄이고 싶었다.

### RemoteDB

| |Firebase|
|-|-|
|특징|1. Google에서 제공하는 모바일 앱개발 플랫폼 </br>2. NoSQL DB 라이브러리</br>3. 실시간으로 사용자 간에 데이터를 저장하고 동기화함</br>4. 구조화된 JSON 및 Collection 데이터 처리에 적합
|장점|1. 직관적으로 데이터 베이스 구조 파악이 쉬움</br>2. Android와 공유가 가능</br>3. 다른 DB에 비해 비교적 저렴</br>4. Analytics를 제공하여 다수의 사용자의 앱 사용 패턴에 대한 통계를 확인
|단점|1. Google에서 지원하므로 iOS 보다 Android에 최적화되어 있음 (ex. device testing 등)</br>2. 데이터 저장용량이 제한적임 (무료 최대 1GB)</br>3. 다른 트리의 다른 노드에 대한 참조는 수동으로 관리해야함</br>4. 종종 서버의 응답속도가 느려짐</br>5. 쿼리가 빈약 (or 문이나 Like문 같은 경우 데이터를 모두 받아와서 직접 필터링 해주어야한다.)
|선정이유| 현업에서의 사용 빈도와 안드로이드와의 호환성을 고려했습니다.

---
1. 하위 버전 호환성에는 문제가 없는가?
CoreData는 ios8이상, Firebase는 ios10이상부터 사용가능

2. 안정적으로 운용 가능한가?, 미래 지속가능성이 있는가?
- Firestore: 3백만 개 이상의 어플에서 활용되고 있고, 현재에도 꾸준하게 업데이트 되고 있는 라이브러리
- Coredata: iOS의 first-party DB이기 때문에 애플에서 꾸준한 업데이트를 할 것이라 예상함.

4. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
Cocoapods, SPM, Carthage을 사용할 수 있으나 사용하는 모든 라이브러리가 CocoaPods을 지원하고, 개인적으로도 가장 익숙한 Cocoapods을 선택했습니다

## 📦 파일 구조
```
.
├── AppDelegate.swift
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   └── Contents.json
│   └── Contents.json
├── Info.plist
├── Model
│   ├── Extension
│   │   └── Date+formatter.swift
│   ├── Manager
│   │   ├── Protocol
│   │   │   └── DBManagerable.swift
│   │   └── TodoDataManager.swift
│   ├── Status.swift
│   └── Todo.swift
├── SceneDelegate.swift
├── View
│   ├── MainView.swift
│   ├── NavigationBarModifier.swift
│   ├── TodoContentView.swift
│   ├── TodoListRow.swift
│   └── TodoListView.swift
└── ViewModel
    ├── MainViewModel.swift
    ├── TodoContentViewModel.swift
    ├── TodoListRowViewModel.swift
    └── TodoListViewModel.swift
 ```
 
 ## 📱 동작 화면
 
- Add 버튼을 통한 할 일 추가

![](https://i.imgur.com/Xxc3zVQ.gif)

- 할 일 수정

![](https://i.imgur.com/2ubLabv.gif)

- 스와이프 삭제

 ![](https://i.imgur.com/pjrhmpN.gif)
 
- popover를 통한 상태 변경

![](https://i.imgur.com/NCQQCh2.gif)

## 💡 키워드

- SwiftUI
- MVVM
- Property Wrapper
- CoreData
- FireBase

## 🤔 핵심경험

- [x]  다양한 기술 중 목적에 맞는 기술선택
- [x]  내가 선택한 기술을 통한 UI구현
- [x]  Word wrapping 방식의 이해
- [x]  리스트에서 스와이프를 통한 삭제 구현
- [x]  Date Picker를 통한 날짜입력

## 📚 참고문서

* SwiftUI Tutorials
* List
  * Displaying Data in Lists
* Pickers
  * DatePicker
* popover(isPresented:attachmentAnchor:arrowEdge:content:)
* Compare iOS Databases
* DateFormatter
* Handling Notifications and Notification-Related Actions
* UndoManager
* Scheduling a Notification Locally from Your App
* Localizations

## 🚀 TroubleShooting
    
### 🚀 STEP 2

#### 1.
1. todoData status 변경시

![](https://i.imgur.com/d7k8fYG.gif)

2. 삭제 시 

![](https://i.imgur.com/gJTBH0O.gif)

위에 영상처럼 status를 변경하거나, 삭제를 할 경우 뷰에서 제대로 업데이트를 하지 못하고 각각의 row뷰의 내용들이 뒤죽박죽 섞이는 현상을 겪었었음, 뿐만아니라 Edit을 하였을 때에도 변경사항을 반영하지 못하는 경우가 있었음 

하지만 todoDataManager 내부의 모델 데이터는 문제 없이 변경이 되었기 때문에 이는 뷰의 문제라고 생각

그래서 해당 데이터를 담당하는 뷰인 TodoListRow 뷰를 리팩토링 하기 시작 하였고 여러 고민 끝에 아래의 사진들 처럼(1번을 2번으로) StateObject를 ObservedObject로 변경하였더니 모든 문제가 사라졌음
1. 

![](https://i.imgur.com/ofwfjaa.png)

2. 

![](https://i.imgur.com/gYfF03F.png)


#### 2.
1.

![](https://i.imgur.com/cKhLtYC.png)

2. 

![](https://i.imgur.com/yyu7shJ.png)

내용을 Edit하거나 Add 할때 사용 하는 뷰인 TodoContentView를 띄운다음 작업을 진행하고 해당 뷰를 화면에서 사라지게 하면 위에 사진에서 보이는 오류가 계속해서 발생 

xcode 업데이트로 인한 문제로 낮은 버전에서는 해당오류가 발견되지 않음 

#### 3.
현재 swiftUI 에서는 Nested ObservableObjects 인식하지 못함 ([스택오버플로우](https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects)) 그래서 콤바인을 사용하여 아래의 사진과 같이 해결

![스크린샷 2022-09-27 오후 11 01 06](https://user-images.githubusercontent.com/101521502/192547621-d3030cbc-5a5c-4366-8543-248791244b1d.png)
 
