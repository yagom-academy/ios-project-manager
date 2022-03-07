# 📱 프로젝트 관리 앱

## 목차 

- [STEP 1](#STEP1)
  - [프로젝트 적용 기술 고민](#STEP1_1)
- [STEP 2-1](#STEP2-1)
  - [프로젝트 구조](#STEP2-1-구조)
  - [고민했던 점](#STEP2-1-1)

<a name="STEP1"></a>
# 🤔 Step 1

<a name="STEP1_1"></a>
## 🔥 프로젝트 적용 기술 고민

|카테고리|기술|
|:---:|:---:|
|UI|Rxcocoa|
|구조|MVVM|
|Local/Remote 저장소|FireStore|


### 1️⃣ Local & Remote 데이터 저장 방식

- `FireStore` 를 선택하여 Local/Remote 데이터 관리해보고자 합니다. 대략적인 선택 이유를 먼저 말씀드리고 아래에 고민 포인트들에 대해 생각해본 내용을 적어보았습니다!
- 선택 이유
    - 크로스 플랫폼 SDK를 지원한다는 점에서 확장성이 좋다는 장점이 있다
    - 개인 앱이나 작은 규모의 프로젝트를 진행할 때 서버로 많이 사용한다고 알고 있습니다!
    - 오프라인 상태일 때도 데이터에 액세스 할 수 있어 다양한 상황에 대응할 수 있다는 것이 장점이라고 생각했습니다. [https://firebase.google.com/docs/firestore/manage-data/enable-offline?hl=ko](https://firebase.google.com/docs/firestore/manage-data/enable-offline?hl=ko)
    - Realtime Database vs FireStore 사이에서 고민했습니다.
        - 먼저 [https://firebase.google.com/docs/firestore/rtdb-vs-firestore?hl=ko](https://firebase.google.com/docs/firestore/rtdb-vs-firestore?hl=ko) 링크를 참조하여 확인해봤습니다.
        - FireStore는 Realtime Database보다 뒤에 나온 업데이트 버전이다
        - FireStore는 조금 더 직관적인 collection 타입으로 데이터를 저장/관리한다
        - FireStore는 단일 쿼리에서 속성에 여러 필터를 연결하고 필터링과 정렬을 결합할 수 있다
        
        → 결론적으로, 프로젝트 규모가 크지 않기 때문에 두 선택 사이에서 유의미한 차이는 없겠지만, 비교적 최신 서비스이며 더 다양한 쿼리를 사용할 수 있는 `FireStore`의 장점을 경험해보고 싶었습니다. 또한 사용자가 오프라인 상태일 때 로컬 데이터에 대한 정교한 쿼리 기능을 사용하려면 FireStore를 사용하는 게 좋다고 문서에서 추천하여 선택하게 되었습니다.

- 1️⃣ 하위 버전 호환성에는 문제가 없는가?
    - Firebase는 iOS 10 이상을 타겟팅하고 있습니다.
    - [https://developer.apple.com/kr/support/app-store/](https://developer.apple.com/kr/support/app-store/) 를 참고했을 때 iOS 14 이상이 98%로 하위 버전 호환성에는 문제가 없지 않을까 생각했습니다.
- 2️⃣ 안정적으로 운용 가능한가?
    - 구글에서 지원하는 데이터베이스로 풍부한 레퍼런스와 가이드가 존재하고 있습니다!
    - 구글이라는 큰 기업에서 운영한다는 안정성..?이 있지 않을까 싶습니다.
- 3️⃣ 미래 지속가능성이 있는가?
    - Realtime Database에서 좀 더 업데이트된 FireStore를 출시한 것을 보면, 앞으로도 더 좋은 방향으로 개선되거나 서비스가 나올 수 있다고 생각됩니다.
- 4️⃣ 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
    - 데이터 트랜잭션이 많아질 경우 비용이 발생할 수 있다는 점
        
        → 대용량 데이터를 다루거나, 대용량의 쿼리를 보내지 않을 예정이기에 비용에 대한 문제는 발생하지 않을 것이라 생각합니다.
        
    - 데이터 베이스 자체의 에러 혹은 서비스의 지속성
        
        → 구글에서 관리한다는 점, 세계적으로 여러 유명 기업들이 사용하고 있다는 점에서 급작스레 서비스가 종료될 일은 없지 않을까 싶습니다.
        
        → 또한 github을 보면 꾸준히 최근에도 업데이트 되고 있는 모습을 보여 안정적으로 사용할 수 있을 것이라고 생각합니다.  https://github.com/firebase/firebase-ios-sdk
        
- 5️⃣ 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
    - Cocoapods, SPM, Carthage
    - Cocoapods의 경우 유서깊은 의존성 관리도구로 여러 라이브러리들을 지원하는 third-party툴로 많이 사용한다고 알고 있습니다. 하지만 SPM이 first-party라는 장점이 가장 크고, 제가 사용하고자 하는 `FireStore`, `RxCocoa` 등 모두 SPM이 지원하고 있기에 이번 프로젝트에서는 SPM을 이용해보고자 합니다.
- 6️⃣ 이 앱의 요구 기능에 적절한 선택인가?
    - `FireStore`는 로컬/리모트 데이터의 동기화의 조건을 한 번에 충족시킬 수 있다
        
        → 인터넷이 없을 때에는 로컬의 캐시를 사용하고, 서버 연결이 다시 정상화 되면 다시 서버의 데이터베이스와 연동된다고 알고 있습니다. 
        
    - 작은 크기의 데이터들이 CRUD된다는 점에서는 Realtime Database가 적합하다고 하나, 큰 용량의 데이터가 발생하지 않고, 서버에 큰 영향을 줄 정도의 CRUD가 아니기에 FireStore도 적합하다고 생각했습니다.

<a name="STEP2-1"></a>

# 🤔 STEP 2-1

<a name="STEP2-1-구조"></a>

## 📱 프로젝트 구조 

![image](https://user-images.githubusercontent.com/45652743/156529468-3d97e908-2c3b-4328-9e9e-2a07625fc26e.png)


<a name="STEP2-1-1"></a>

## 🔥 고민했던 점

### 1️⃣  MVVM 패턴의 구조

MVVM 구조를 구현함에 있어 View ↔  ViewModel 사이에서 데이터 변화를 관측하고, 스스로 UI를 변경할 수 있도록 하기 위한 방법들에 대해 고민해봤습니다. 

- Observable 구현
    - Rx와 가장 닮아있는 방식이라고 생각했으며 동시에 Rx를 구현하는...? 방법이지 않을까 생각이 들었습니다.
    - 이에 커스텀하게 Observable을 만들 경우, 추후에 operator를 직접 만들어야 하는 경우가 발생할 것 같아서 현재로서는 선택하지 않게 되었습니다.
- Protocol
    - Protocol을 통해 구현하는 방식은 delegate pattern 처럼 동작하고 있다고 생각했습니다.
    - delegate를 할당해주어야 하며, 그나마 delegate pattern은 다른 부분에서 경험해본 방법이어서 이번에는 다른 방법을 사용해보려고 했습니다
- Closure
    - ViewModel내에 closure를 정의하고 호출이 필요한 곳에 위치시켜둔 후, ViewController에서 해당 클로저를 구현하여 작동하는 방식입니다.
    - 여러 자료들을 봤을 때, Rx없이 구현하기에 가장 보편적인 방법이라고 생각했습니다.

그래서 이번에 UIKit+MVVM으로 프로젝트를 구현하기 위해서는 closure 방식을 선택했습니다. 

### 2️⃣  Clean Architecture

MVVM에 대해 공부하다보니 Clean Architecture가 따라오는 것 같아 이를 함께 적용해봤습니다. 

- ViewModel: 화면에 필요한 데이터를 제공하는 역할
- Domain: 앱의 실행에 있어 필요한 비즈니스 로직을 수행하는 역할
- Repository: 데이터를 불러오는 역할

역할들을 나누어, View ↔ ViewModel ↔  Domain ↔  Repository 구조로 구성해보았습니다. 

요구사항에 따라 현재는 memory 기반의 repository가 위치해있지만, 이후에 Local/Remote DB가 올 것을 대비하여 Repository 프로토콜을 구현하여 추상화 해주었습니다. 이러한 추상화를 통해 추후 Remote Repository가 위치했을 때에도 mock Repository를 두어 Domain의 로직을 테스트 할 수 있다는 장점이 있다는 것을 학습했습니다

또한 Domain에 해당하는 `ToDoManager` 의 역할, ViewModel인 `ToDoViewModel` 도 마찬가지로 핵심 역할을 추상화하였습니다.   

### 3️⃣ Unit Test 코드 작성

비즈니스 로직을 담당하는 Domain의 `ToDoManager`의 Unit Test를 진행했습니다. 

현재는 memory 기반의 repository이기 때문에 별도의 mock repository를 두지는 않았으며, 추후 remote repository가 위치하게 될 경우, unit test 코드 또한 변경해주고자 합니다.
