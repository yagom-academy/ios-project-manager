# 프로젝트 매니저

## 소개
해야할 일을 `TODO`, `DOING`, `DONE`으로 관리하는 프로젝트 매니저입니다.


## 프로젝트 기간
> 프로젝트 매니저 I 2022.07.04(월) ~ 2022.07.15(금) 리뷰어: [린생](https://github.com/jungseungyeo)

> 프로젝트 매니저 II 2022.07.18(월) ~ 2022.07.29(금) 리뷰어: [린생](https://github.com/jungseungyeo)


## 목차
- [1. 트러블 슈팅](#트러블-슈팅-/-고민한-점)
- [2. 기술 스택(DB) 선택 과정](#DB-선택-과정)
- [3. 실행화면](#실행화면)


## 기술 스택
<img width="600px" src="https://i.imgur.com/T9L9x8d.png"/>


## PR 및 코드 리뷰
|STEP 1|STEP 2|
|:---:|:---:|
|[STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/120)|[STEP2-1](https://github.com/yagom-academy/ios-project-manager/pull/131)|
||[STEP2-2](https://github.com/yagom-academy/ios-project-manager/pull/136)|
||[STEP2-3](https://github.com/yagom-academy/ios-project-manager/pull/137)|


## 트러블 슈팅 / 고민한 점

RxSwift와 MVVM, Input/Output 패턴을 적용해보면서 다음의 고민이 있었습니다.

1. Stream이 ViewModel에서 끝나지 않고 ViewController에서 끝날 수 있도록 해야하는가?
2. Stream이 분기되면서 불필요한 곳에도 Reload가 되고 있지 않을까?

**Stream이 ViewModel에서 끝나지 않고 ViewController에서 끝날 수 있도록 해야하는가?**
Input/Output 패턴을 공부하면서 어느 블로그 글에서는 <U>ViewModel과 ViewController 둘다 DisposeBag을 프로퍼티에 구현하여 Stream이 종료</U> 될 수 있도록 하는 곳도 있었고 <U>ViewController에서 출발한 Stream이 ViewModel에서 dispose 되지 않고 ViewController에서 dispose 될 수 있도록 구성</U> 해야한다는 의견도 있어 어떻게 구성해야할 지 헷갈리는 부분이 있었습니다.

만약, ViewController에서 Stream을 끝나도록 해야하고 ViewModel에서 Stream이 끝나야하는 경우 아래와 같이 ViewController의 disposeBag을 가져와서 끝내줘야할 지 고민을 하게 되었습니다.
```swift
func transform(input: Input, disposeBag: DisposeBag) -> Output
```

**Stream이 분기되면서 불필요한 곳에도 Reload가 되고 있지 않을까?**
기존에는 한 개의 Card 배열을 CardType을 기준으로 필터링을 하여 각각의 TableView들에게 이어지도록 Stream을 구성했었습니다. Todo를 추가하면 Doing, Done TableView 모두에게 불필요한 영향을 Reload를 하고 있다는 것을 확인하였고 `distinctUntilChanged()`로 변경점이 있을때만 방출할 수 있도록 변경했습니다.


**상속과 Composition 구조**
새로운 카드를 생성하기 위한 Form과 카드의 상세내용을 표시하는 Form의 UI가 일치하기 때문에 공통 요소 재사용을 어떤 방식으로 구현해야할 지 다음의 방식 중 고민했습니다.

1. **상속(Inheritance) 구조**를 통한 공통 요소 재사용
2. **합성(Composition) 구조**를 통한 재사용

이 중 Composition 구조를 통해 재사용되는 공통 요소를 뽑아냈습니다. 상속 구조를 채택하지 않은 이유는 다음과 같습니다.

상속 구조는 공통 요소를 재사용하기 매우 편하고 쉽게 구현할 수 있는 방식이지만 기능 개발이 계속 진행되면 될수록 버그가 발생하게 되고 어디서 문제가 발생했는지 파악하기 어렵게 되는 단점이 있고 상속을 하기 위해서는 부모 클래스의 프로퍼티나 메소드를 `private`로 캡슐화가 불가능하다는 점 또한 상속을 채택하지 않은 이유입니다.

<img width="400" src="https://i.imgur.com/dp8Hpnl.png"/> <br/>

따라서, 공통 UI 요소를 CardEditView로 분리한 후 프로퍼티로 생성해주었습니다.

**Compostion 구조**로 구현하면서 느낀점은 교체하기 편리할 것 같다는 생각이 들었습니다. 
예를 들어, 구현이 필요한 각 영역을 Mock View를 프로퍼티로 생성 후 오토레이아웃을 잡아놓고 추후에 구현이 완료된 View로 교체해서 넣어주면 마치 부품을 조립하듯이 UI를 구성할 수 있겠다는 생각이 들었습니다.

**MVVM Input/Output 구조**

```swift
protocol ViewModelType {
  associatedtype Input
  associatedtype Output
    
  func transform(input: Input) -> Output
}
```

이전 STEP2-1에서 구현된 ViewModelType 타입과 transform 메서드를 통한 처리 방식은 ViewModel 교체와 테스트를 어렵게 만들고 기능이 많아질수록 transform에서 구현되어야할 코드의 양이 기하급수적으로 증가하게되어 ViewModel이 Massive 하게될 가능성이 있는 구조였습니다.

<img width="600" src="https://i.imgur.com/uwQDMXg.png"/> <br/>

위와 같이 구조로 변경하여 ViewModel를 사용하는 곳에서는 ViewModel 프로토콜을 바라보고 있기 때문에 
ViewModel과 ViewController간의 의존성을 낮추게 되어 교체가 용이하게되고 테스트하기 좋은 구조로 변경했습니다.

<img width="350" src="https://i.imgur.com/nmAAIT8.png"/> <br/>

`transform` 메서드만으로 전달되는 구조가 아니기 때문에 유연하게 데이터를 전달할 수 있게 되었습니다.

**화면 전환에 대한 고민**
기능 개발이 이뤄지면서 띄워야하는 장면이 증가하고 `present/dismiss` 또는 `push/pop`을 호출해야하는 상황에서 새로운 ViewController를 생성하여 화면 전환을 하게 되는데 

화면을 전환하기 위해서는 해당 ViewController가 다른 ViewController를 소유하고 있어야 하기 때문에 <U>서로 간의 의존성이 증가</U>하고 이곳 저곳에서 구현되어 있는 <U>화면 전환 코드를 관리하기 힘들어질 것 같</U>습니다.

화면 전환 문제에 대해 Coordinator 패턴을 하나의 해결책으로 제시하는 글들을 찾을 수 있었고 이번 STEP2-3에서는 적용하지 못했지만 남은 기간동안 Coordinator 패턴 적용과 Coordinator를 통한 의존성 주입에 대해 고민해보면 좋을 것 같다는 생각이 들었습니다.

**ViewModel과 ViewController**

프로젝트 코드에서 CardListViewController, CardAdditionViewController, CardDetailViewController가 하나의 CardListViewModel 객체를 주입 받는 형태로 구현되어 있고 이렇게 구현된 이유로는 Card를 저장하는 배열을 각각의 ViewController에서 공유해야하기 때문에 1:1이 아닌 1:N의 구조가 되었다고 생각합니다.

하나의 ViewModel를 여러 ViewController이 사용하도록 구현되어 있다면 CardListViewController에서 사용하지 않는 로직이 CardListViewModel에 구현되어 있는 문제가 있다고 생각했습니다. 하지만 공유하지 않고 분리하게 된다면 데이터 공유 문제와 중복 로직이 발생할 가능성이 있을 것이며 이를 해결하기 위해 `DataManager`로 공유가 필요한 데이터를 관리하는 계층을 더 추가하는 것도 데이터 공유 문제를 해결할 수 있는 좋은 방법이라고 생각했습니다.

**Long Press 이벤트에 대한 처리**

길게 터치하는 이벤트가 전달되기 위해 `UILongPressGestureRecognizer`를 사용하였습니다. 해당 이벤트가 발생하고 팝오버 메뉴를 표시하기 위해 처음에는 UIKit스럽게 Target-Action 방식으로 구현을 시도했었습니다. 하지만, Rx를 제대로 활용하지 못한다고 생각했고 아래 코드와 같이 기능을 확장하여 구현했습니다.
 
<img width="800" src="https://i.imgur.com/GOR0539.png"/> <br/>

`modelLongPressed`라는 메서드를 정의하고 Long 제스처를 Base가 되는 TableView에 추가한 후 제스처 이벤트가 발생하면 아래의 과정으로 데이터를 처리한 후 Cell과 데이터를 방출하도록 설계했습니다.

![](https://i.imgur.com/T6tIfJ6.png)


<img width="600" src="https://i.imgur.com/hCNOJni.png"/> <br/>

구현된 `modelLongPressed`를 ViewController에서 사용하여 길게 터치하는 이벤트에 대한 처리를 ViewModel에서 처리하도록 로직을 분리했습니다.


## DB 선택 과정

> 로컬 DB에는 `Core Data` / 원격 DB에는 `Firebase Realtime Database` 로 결정했습니다. 

### 💬 **하위 버전 호환성에는 문제가 없는가?**

✅ [iOS 및 iPad OS 사용 현황](https://developer.apple.com/kr/support/app-store/)을 보면 iPad의 경우 90%이상이 iOS 15 버전을 사용한다는 것을 알 수 있었고 
Core Data는 iOS 3.0 /  Firebase는 iOS 10.0 부터 지원하기 때문에 하위 버전 호환성 문제는 없다고 판단하였습니다.

|iPhone|iPad|
|:---:|:---:|
|<img width="300px" src="https://i.imgur.com/A2mxBmX.png"/>|<img width="315px" src="https://i.imgur.com/ff0XpWg.png"/>|

### 💬 **안정적으로 운용 가능한가?**

✅ Core Data의 경우 Apple의 First-Party 프레임워크이기 때문에 안정적으로 운용 가능할 것으로 판단됩니다.  
✅ Firebase는 구글의 서비스로써 지속적인 유지보수가 이뤄지고 있고 많은 곳에서 사용되어 검증된 기술이므로 안정적인 운용 가능할 것으로 판단했습니다.


### 💬 **미래 지속 가능성이 있는가?**

✅ Core Data의 경우 Apple의 First-Party 프레임워크이기 때문에 지속 가능할 것으로 판단됩니다.   
⚠️ Firebase는 구글에서 서비스하고 있는 Third-Party이므로 언제든지 종료 가능성이 있다고 생각됩니다. 구글은 성과가 없는 프로젝트에 대해 서비스 종료한 과거 사례가 있기 때문에 완전히 안정적이다 라고 볼 수 없을 것 같습니다. 하지만, Firebase는 충분한 성과를 이룬 프로젝트이고 지속적인 유지보수가 이뤄지고 있으며 아직도 많은 곳에서 사용되고 있기 때문에 지속 가능성이 있다고 생각합니다.


### 💬 **리스크를 최소화 할 수 있는가? 알고 있는 리스크는 무엇인가?**

✅ Core Data의 경우 Thread-Safe 하지 않는 리스크가 있기 때문에 관련 기능을 추가적으로 구현하여 최소화할 수 있습니다.  
✅ Firebase의 경우 비용 문제가 발생할 수 있지만 초기 서비스에서는 초과할 가능성이 적을 것으로 예상되어 문제가 없을 것으로 생각됩니다.


### 💬 **어떤 의존성 관리도구를 사용하여 관리할 수 있는가?**

대표적인 의존성 관리도구로는 CocoaPod, Carthage, Swift Package Manager(SPM)이 있습니다. 
SPM은 애플의 First-Party 의존성 관리도구이며 이번 프로젝트에서 사용하기로 정한 라이브러리 모두 지원하고 있기 때문에 SPM을 선택했습니다.

✅ Core Data는 애플의 First-Party 프레임워크이므로 의존성 관리 도구를 사용할 필요가 없습니다.  
✅ Firebase Realtime Database는 Swift Package Manager를 지원합니다.


### 💬 **이 앱의 요구 기능에 적절한 선택인가?**

`Realtime Database`와 `Cloud FireStore` 중 무엇을 선택해야할 지에 대한 다음의 고민이 있었습니다.

1. 어느 것이 프로젝트의 성격에 부합하는가?
2. 어느 것이 비용 정책에서 유리한가?

**1️⃣ 어느 것이 프로젝트의 성격에 부합하는가?**

<img width="600" src="https://i.imgur.com/WbgwBlL.png"/>

**2️⃣ 어느 것이 비용 정책에서 유리한가?**

|Realtime Database|Cloud FireStore|
|:---:|:---:|
|![](https://i.imgur.com/diDJMBM.png)|![](https://i.imgur.com/nPHE2aI.png)|

Cloud FireStore는 `CRUD`를 기준으로 비용을 책정하기 때문에 `CRUD`가 자주 발생한다면 Realtime Database가 유리하고 큰 단위의 데이터 요청이 자주 발생한다면 Firestore가 유리할 것이라고 판단했고 프로젝트의 성격과 각각의 비용 정책을 고려한 결과 **Realtime Database** 로 결정하게 되었습니다.

### DB - Repository - UseCase - ViewModel - ViewController 데이터 Flow에 대해
이번 프로젝트 매니저 II에서 I과 달리 계층을 늘리는 과정에서 데이터 Flow를 ViewController에서 Disposed 되어야할까? UseCase에서 스트림을 한번 끊어야 할까? 에 대해 고민이 있었습니다.

기본적으로 내부에서 외부를 모르도록 설계하는 것이 클린 아키텍쳐가 지향하는 구조이며 <U>단방향 데이터 흐름</U>을 가져감으로써 아래와 같은 장점을 얻을 수 있다고 생각합니다.

1. 데이터가 한 방향으로만 전달되기 때문에 문제가 발생했을때 어디서 디버깅하기 좋다.
2. 전체적인 앱의 실행 흐름을 파악하기 쉽다.

<img width="500" src="https://i.imgur.com/tbvoj3B.png"/>

[그림 출처](https://medium.com/tiendeo-tech/ios-rxswift-clean-architecture-d7e9eaa60ba) / [참고 자료: Medium_Clean Architecture](https://medium.com/@jonas.schaude/developing-ios-applications-with-uncle-bobs-clean-architecture-572084853cdc)

따라서, View에서 요청을 하면 DB까지 요청 메시지가 전달되고 반환되는 응답 스트림이 끊어지지 않도록 구현했습니다.

### DI Container 
계층이 많아지고 주입해줘야하는 객체가 늘어남에 따라 의존성 관리하는 것이 어려워질 것 같다는 생각이 들었습니다.

<img width="500" src="https://i.imgur.com/vunI3Q0.png"/> <br/>

사용할 때마다 UseCase 인스턴스 하나를 생성하기 위해 위와 같이 작성하다보면 Coordinator 코드도 비대해질 것 같습니다. 이를 해결할 방법으로 DIContainer를 통한 의존성 관리를 고려했고 Swinject, PureDI 등 많은 DI 라이브러리가 있지만 직접 구현해보자고 생각했습니다.

직접 구현할 DIContainer의 주요 목표 기능은

1. 필요할 때 생성할 수 있도록 지연 생성을 지원해야한다.
2. 중복 생성되지 않도록 캐싱을 지원해야한다.
3. 하위 객체부터 상위 객체로 조합하며 생성되어야한다. (IoC)


**1. 필요할 때 생성할 수 있도록 지연 생성을 지원해야한다.**
DIContainer가 필요한 인스턴스를 처음부터 생성하고 가지고 있다면 메모리를 낭비하게되기 때문에 사용할 때 생성될 수 있도록 해야합니다. 지연 생성을 구현하기 위해 <U>클로저의 지연 평가</U>를 활용했습니다.

**2. 중복 생성되지 않도록 캐싱을 지원해야한다.**
이미 생성된 인스턴스를 다시 생성하지 않도록하여 메모리 낭비를 줄여야합니다.

**3. 하위 객체부터 상위 객체로 조합하며 생성되어야한다.**
아래의 그림과 같이 Storage부터 생성되고 ViewController까지 역순으로 생성되어야합니다.

<img width="800" src="https://i.imgur.com/T1hH3Tg.png"/> <br/>

위의 요구조건을 만족하도록 아래와 같이 구현해보았습니다.

<img width="500" src="https://i.imgur.com/BxyOmeB.png"/> <br/>

**UseCase의 로직의 공통 요소에 대해**

구현하는 과정에서 각각의 CRUD에 대한 노티피케이션 설정, Undo-Redo 관리 로직 등에서 공통된 요소들이 많은 것 같습니다.
대표적으로 아래의 첨부된 코드에서 `FlatMap`과 내부 로직이 중복되고 있는 것을 확인할 수 있는데 이러한 스트림을 이어주는 과정에서 발생한 중복 요소를 개별 함수로 빼는 것이 좋을지 고민이 되었습니다.

<img width="500" src="https://i.imgur.com/TkzMulC.png"/> <br/>

<img width="500" src="https://i.imgur.com/hXtmGYc.png"/> <br/>

**테스트 코드의 중요성**

이번 프로젝트에서는 테스트 코드없이 진행하게 되었습니다. 점점 기능이 많아지고 규모가 커지면서 예상하지 못한 곳에서 문제가 발생하는 경우도 있었고 해당 기능이 제대로 동작하는지 확인하기 위한 <U>계속된 디버깅 작업</U>과 구현된 <U>코드를 신뢰할 수 없는 등의 어려움</U>이 있었습니다. 이번 기회를 통해 테스트 코드 작성의 필요성을 한번 더 느꼈고 이후 프로젝트에서는 테스트 코드를 무조건 작성해야겠다는 다짐을 얻을 수 있었던 계기가 된 것 같습니다. 

## 실행화면

|[메인 화면] 앱 시작|[메인 화면] 한국어 설정|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/iRV42qz.gif"/>|<img width="400" src="https://i.imgur.com/VKxPymY.png"/>|

|[메인 화면] 영어 설정|[메인 화면] 일본어 설정|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/hSF72A1.png"/>|<img width="400" src="https://i.imgur.com/m7sf27r.png"/>|

|[메인 화면] 카드 생성|[메인 화면] 카드 생성 취소|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/Kl6SpGJ.gif"/>|<img width="400" src="https://i.imgur.com/n76Ef5k.gif"/>|

|[메인 화면] 카드 수정|[메인 화면] 카드 디테일 - 편집모드 X|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/wRVMNJB.gif"/>|<img width="400" src="https://i.imgur.com/4PoJmjJ.gif"/>|

|[메인 화면] 카드 디테일 - 편집모드 O|[메인 화면] 카드 상세 화면|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/n6zw6mE.gif"/>|<img width="400" src="https://i.imgur.com/JNkvRPK.gif"/>|

|[메인 화면] 카드 Swipe 삭제|[메인 화면] 카드 일반 삭제|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/SztzZ4b.gif"/>|<img width="400" src="https://i.imgur.com/STlPlIs.gif"/>|

|[메인 화면] 카드 팝오버 표시|[메인 화면] 카드 팝오버 Section 이동|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/CoeyFZk.gif"/>|<img width="400" src="https://i.imgur.com/lLARdES.gif"/>|

|[메인 화면] 카드 이동 시 마감 시간순 정렬|
|:---:|
|<img width="400" src="https://i.imgur.com/xNVHnq3.gif"/>|


|[메인 화면] 히스토리 I|[메인 화면] 히스토리 II|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/SIyPRVM.gif"/>|<img width="400" src="https://i.imgur.com/RZ3feL2.gif"/>|

|[메인 화면] 히스토리 III|[메인 화면] Core Data 캐시|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/Uj8K0rB.gif"/>|<img width="400" src="https://i.imgur.com/2rYcjQd.gif"/>|

|[메인 화면] Firebase 동기화 - 앱 재설치|[메인 화면] 네트워크 연결 상태|
|:---:|:---:|
|<img width="400" src="https://user-images.githubusercontent.com/94151993/180363892-a149f91b-8ddf-4795-9207-e18793a06bbc.gif"/>|<img width="400" src="https://i.imgur.com/porBnvJ.gif"/>|

|[메인 화면] 동기화 애니메이션|[메인 화면] 마감일 알림|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/Qrv6ub4.gif"/>|<img width="400" src="https://i.imgur.com/Y2WoDuk.gif"/>|

|[메인 화면] 생성 Undo Redo|[메인 화면] 업데이트 Undo Redo|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/BW56lgR.gif"/>|<img width="400" src="https://i.imgur.com/9T5ME5J.gif"/>|

|[메인 화면] 삭제 Undo Redo|[메인 화면] 이동하기 Undo Redo|
|:---:|:---:|
|<img width="400" src="https://i.imgur.com/N9sIVkt.gif"/>|<img width="400" src="https://i.imgur.com/Nyiuw9X.gif"/>|