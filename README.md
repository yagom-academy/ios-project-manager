# 🗂️ 프로젝트 매니저
> 사용자의 일정을 표시하는 iPad 앱입니다.
> * 주요 개념: `MVVM`, `Combine`
> 
> 프로젝트 기간: 2023.05.15 ~ 2023.06.02

### 💻 개발환경 및 라이브러리
<img src = "https://img.shields.io/badge/swift-5.8-orange"> <img src = "https://img.shields.io/badge/Minimum%20Diployment%20Target-13.0-blue"> <img src = "https://img.shields.io/badge/CocoaPods-1.11.3-brightgreen"> 

<img src = "https://img.shields.io/badge/Firebase-10.9.0-red">

## ⭐️ 팀원
| Rowan | Brody |
| :--------: |  :--------: |
| <Img src = "https://i.imgur.com/S1hlffJ.jpg"  height="200"/> |<img height="200" src="https://avatars.githubusercontent.com/u/70146658?v=4" width="200">|<img src="https://github.com/Andrew-0411/ios-diary/assets/45560895/2872b119-d22b-46a7-85c4-d9e0c3dd6da8">
| [Github Profile](https://github.com/Kyeongjun2) |[Github Profile](https://github.com/seunghyunCheon) | 

</br>

## 📝 목차

1. [타임라인](#-타임라인)
2. [프로젝트 구조](#-프로젝트-구조)
3. [실행화면](#-실행화면)
4. [트러블 슈팅](#-트러블-슈팅)
5. [핵심경험](#-핵심경험)
6. [참고 링크](#-참고-링크)


</br>

# 📆 타임라인

- 2023.05.15: 기술스택, 저장소 선택.
- 2023.05.16: MVVM 아키텍처 학습.
- 2023.05.17: 메인화면, TodoListViewModel, TodoViewModel 구성.
- 2023.05.18: Combine개념 학습.
- 2023.05.19: 할 일 추가화면 플로우차트, UML, README 작성.
- 2023.05.22: Detail화면 구현 및 Combine적용.
- 2023.05.23: Task추가 시 메인화면에 적용.
- 2023.05.24: 메인 화면 내의 하나의 컬렉션뷰에서 3개의 컬렉션 뷰 사용하도록 변경. 
- 2023.05.25: CollectionViewModel 추상화하여 보일러 플레이트 코드 삭제.
- 2023.05.26: 뷰모델에서 뷰를 제외한 UML 재설계, README 작성.

</br>

# 🌳 프로젝트 구조

## UML Class Diagram
![](https://hackmd.io/_uploads/BJNgOhaH2.jpg)
![](https://hackmd.io/_uploads/HJA763TS2.jpg)

</br>

## File Tree
```swift
└── Diary
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    ├── Model
    │   ├── Task.swift
    │   ├── WorkState.swift
    │   └── Service
    │       └── TaskStorageService.swift
    ├── MainView
    │   ├── MainViewController.swift
    │   ├── MainViewModel.swift
    │   ├── TaskCollectionView
    │   │   ├── TaskCollectionViewController.swift
    │   │   └── TaskCollectionViewModel.swift
    │   ├── TaskCell
    │   │   ├── TaskCell.swift
    │   │   └── TaskCellViewModel.swift
    │   └── HeaderView
    │       ├── HeaderView.swift
    │       └── HeaderViewModel.swift
    ├── DetailView
    │   ├── DetailViewController.swift
    │   └── DetailViewModel.swift
    ├── Protocols
    │   ├── TaskListViewModel.swift
    │   ├── TaskListViewModelDelegate.swift
    │   └── DetailViewModelDelegate.swift
    ├── Extensions
    │   ├── Combine
    │   │   ├── UIControl+Combine.swift
    │   │   ├── UITextView+Combine.swift
    │   │   ├── UITextField+Combine.swift
    │   │   └── UIDatePicker+Combine.swift
    │   └── Array.swift
    ├── Assets
    ├── LaunchScreen
    ├── Info.plist
    └── GoogleService-Info.plist
```

</br>

# 📱 실행화면

~~추후 추가예정~~

</br>

# 🚀 트러블 슈팅

## 1️⃣ MVVM 아키텍처 설계

### 🔍 문제점
![](https://hackmd.io/_uploads/B17nL66Hn.png)
초기 객체 관계를 설계도를 참고하여 코드를 작성한 결과 발생한 문제는 아래와 같습니다.

1. 보일러 플레이트 코드가 많음(Todo / Doing / Done List를 관리하는 ViewController)
2. ViewModel과 ViewController의 역할의 부적절한 설계
    * DiffableDataSource, Snapshot의 관리를 ViewModel이 하고 있던 문제
    * Todo/Doing/Done List 각각의 확장성을 고려하지 않았던 문제
3. Protocol을 통한 추상화에 따라 코드가 더 복잡한 depth / 관계를 가져 가독성 / 객체관계 파악이 어려움
4. List를 구현할 뷰를 TableView에서 CollectionView로 설계 수정 없이 변경한 문제

</br>

### ⚒️ 해결방안
* MVVM 아키텍처에 대한 추가 자료 조사 및 학습
* Class Diagram 재설계

![](https://hackmd.io/_uploads/BJNgOhaH2.jpg)
![](https://hackmd.io/_uploads/HJA763TS2.jpg)

적용 결과
1. CollectionView를 관리하는 뷰컨트롤러를 하나의 타입(TaskCollectionViewController)으로 개선하여 해결
2. DiffableDataSource와 Snapshot 객체의 위치를 TaskCollectionViewController 내부로 변경
3. 복잡한 관계성을 최소화하는 방향으로 Protocol 추상화 설계(TaskListViewModel Protocol 정의, 적절한 Delegation 패턴을 위한 Protocol 정의)
4. UML 재설계 후 CollectionView 사용을 명시

</br>

## 2️⃣ 요구사항에 맞는 레이아웃 설계.
한 화면에 3개의 테이블 뷰가 보여지는 화면을 구현하는 요구사항이 존재했습니다.

초기에는 하나의 컬렉션 뷰에서 컴포지셔널 레이아웃을 사용한다면 각각의 화면에 접근이 쉬워진다고 생각하여 이 방법을 채택했습니다.

</br>

### 🔍 문제점
하지만 이를 구현하면서 다음의 문제가 발생했습니다.
-  section header가 셀 내용과 겹쳐보이는 문제. 
-  각각의 섹션을 listConfiguration을 사용하여 구성했을 때 section의 크기를 잡지 못하는 문제. 
    - 이를 해결하기 위해 각각의 섹션을 list형식이 아니라 compositionalLayout으로 구성했지만 trailingSwipeActionsConfigurationProvider을 추가하지 못하는 문제가 또 발생함.
    -  delete하는 것처럼 보여지는 스크롤뷰를 만들 수는 있으나 애플에서 지원하는 SwipeAction기능을 사용하지 않고 있기에 이때부터 설계가 잘못되었다고 생각.
- 하나의 뷰모델에서 모든 기능을 관리하기에 확장성이 낮아지는 문제. 

<br/>

```swift
 private func collectionViewLayout() -> UICollectionViewLayout {
    let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
    layoutConfiguration.scrollDirection = .horizontal

    let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil,
                                                          top: .flexible(50),
                                                          trailing: nil,
                                                          bottom: nil)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        // 헤더 설정.
        // deleteAction 커스텀 구현해야 함.

        return section
    }, configuration: layoutConfiguration)

    return layout
}
```

</br>

###  ⚒️ 해결방안

위 문제들을 고려했을 때 하나의 컬렉션뷰에서 관리하기 보다는 3개의 컬렉션 뷰를 만드는 것이 좋다고 생각하여 이 방법으로 변경했습니다.

변경이후 다음의 장점이 있었습니다.

- 확장성을 증가시키고 유지보수 용이하게 만들어 개방폐쇄원칙 준수.
- 각각의 뷰가 뷰모델에 1:1관계를 맺고있기 때문에 단일책임원칙을 준수.
- 복잡한 1개의 레이아웃에서 간단한 3개의 레이아웃 구성하여 가독성 증가.

<br/>

```swift
private func collectionViewLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        // 헤더 설정
        // 애플이 적용하는 UIContextualAction사용하여 Delete 구현.

        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.interGroupSpacing = 10

        return section
    }

    return layout
}
```

</br>

# ✨ 핵심경험

<details>
    <summary><big>✅ Combine</big></summary>
</br>

## Protocol
### Publisher
채택한 타입이 시간이 지남에 따라 일련의 값을 전송할 수 있음을 선언하는 프로토콜.
여러가지 구독 메서드를 통해 Subscriber에 자신의 변경사항을 알린다.

**Creating Your Own Publishers**
Publisher 프로토콜을 직접 구현하는 대신 Combine 프레임워크에서 제공하는 여러 타입 중 하나를 사용하여 고유한 Publisher를 만들 수 있다.

* `PassthroughSubject`와 같은 `Subject`의 구체적인 하위 클래스를 사용하여 `send(_:)` 메서드를 호출해 필요에 따라 값을 게시.
* `CurrentValueSubject`를 사용하여 subject의 기본 값을 업데이트할 때마다 값을 게시.
* 커스텀 타입의 속성에 @Published attribute를 추가하여 프로퍼티를 게시.

### Subscriber
Publisher로부터 input을 전달 받을 수 있는 타입을 선언하는 프로토콜.
Subscriber 인스턴스는 Publisher로부터 스트림의 요소를 전달 받는다.

### Subject
외부 호출자가 요소를 게시할 수 있는 메서드를 노출하는 Publisher.
`send(_:)` 를 통해 스트림에 어떤 값을 주입할 수 있다.

</br>

## Property Wrapper
### @Published
해당 프로퍼티 래퍼 attribute로 표시된 프로퍼티는 타입이 publish하게 된다.
* 게시된 프로퍼티의 publisher에는 프로퍼티 이름 앞에 $표시를 추가하여 접근할 수 있다.
* @Published 프로퍼티 래퍼는 class 프로퍼티에만 적용할 수 있다.

</br>

</details>

<details>
    <summary><big>✅ MVVM 활용</big></summary>

</br>

## Model
* 비즈니스 데이터를 가지고 있는 계층. 
* Repository에 데이터를 CRUD하는 로직이 존재.  

## View
* 뷰모델과 연결되는 바인딩이 존재.
* 그 외 레이아웃을 그리는 코드만 존재.
    
## ViewModel
* 데이터 바인딩 대상을 제공. 모델을 직접 노출하거나 특정 모델 멤버를 래핑하는 멤버를 제공.
* UIKit를 import하지않고 뷰에게 바인딩해주는 모델과 Presentation Logic만 존재.
    
    
</details>

<details>
    <summary><big>✅ Compositional Layout활용</big></summary>
</br>

## sectionProvider
* Section안의 요소 간 간격을 주기 위해 `UICollectionViewCompositionalLayout.list`사용이 아닌 `sectionProvider`적용.
## layout.scrollDirection
* 컬렉션 뷰 레이아웃이 스크롤되는 축을 결정하는 속성.
## section.orthogonalScrollingBehavior
* 현재 레이아웃방향의 수직방향으로 스크롤 스타일을 주는 속성.
</details>

---

</br>

# 📚 참고 링크

* [🍎 Apple Docs - Combine](https://developer.apple.com/documentation/combine)
* [🍎 Apple Docs - UIContextualAction](https://developer.apple.com/documentation/uikit/uicontextualaction)
* [🍎 Apple Docs - associatedtype](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/)
* [🍎 WWDC - Combine](https://developer.apple.com/videos/play/wwdc2019/722/)
* [🍎 WWDC - Combine in Practice](https://developer.apple.com/videos/play/wwdc2019/721)
* [곰튀김 - MVVM](https://www.youtube.com/watch?v=M58LqynqQHc)
* [Github - Combine-MVVM](https://github.com/mcichecki/combine-mvvm)
* [Github - todolist-mvvm](https://github.com/jalehman/todolist-mvvm)
* [Github - CombineCocoa](https://github.com/CombineCommunity/CombineCocoa)
