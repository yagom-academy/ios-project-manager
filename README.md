## **프로젝트 관리 앱 [STEP 1] 토니, 조이**

### 기술스택 선정

- CoreData
- Firestore

- 하위 버전 호환성에는 문제가 없는가?
    - firebase 의 기본요건은 다음과 같습니다.
        
        <img src="https://i.imgur.com/OPpkZqd.png)" width="50%" height="50%">
        
        이와 같이 iOS 10 버전이상을 타겟팅하고 있습니다.
        
    - 문서확인 결과 iPhone유저들의 경우 98%이상의 사람들이 iOS14 이상을 사용하고 있고, iPad유저들의 경우 96%이상의 사람들이 iPadOS 14 이상을 사용하고 있습니다.
        
        
        |iPhone|iPad|
        |:---:|:---:|
        |<img src="https://i.imgur.com/9ugfJpm.png" width="70%" height="50%">|<img src="https://i.imgur.com/R8LWExd.png" width="70%" height="50%">|
        
        [https://developer.apple.com/kr/support/app-store/](https://developer.apple.com/kr/support/app-store/) 
        
- 안정적으로 운용 가능한가?
    - 구글이 소유하고 있는 모바일 애플리케이션 개발 플랫폼이라서 안정적이라고 할 수 있을 것 같습니다.
- 미래 지속가능성이 있는가?
    - 현재에도 많은 곳에서 사용되고 있고 구글이 갑작스럽게 서비스를 종료할 것으로 예상되지는 않기 때문에 미래 지속가능성이 있을 것 같습니다.
- 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
    - 딱히 생각나는 리스크가 없습니다.
- 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
    - spm / cocoapods을 사용하여 관리할 수 있습니다.
    - 그 중 저희는 spm을 이용할 예정입니다. 이유는 다음과 같이 2가지로 볼 수 있습니다.
        - 1. 애플에서 지원하는 first party.
        - 2. 별도의 설치가 필요없이 Xcode내부에서 사용가능.

---

### ❓ 궁금한 점 🤔

<img src="https://i.imgur.com/cxG3B5I.png" width="70%" height="50%">

[https://firebase.google.com/docs/firestore/manage-data/enable-offline?hl=ko](https://firebase.google.com/docs/firestore/manage-data/enable-offline?hl=ko)

파이어베이스 홈페이지 <오프라인으로 데이터에 액세스> 부분을 보면 위와 같은 말이 나와있습니다. 위 글만 읽으면 firestore가 로컬저장소를 대체할 수 있을 것 같은데 과연 로컬에서도 필요할까라는 궁금증을 가졌습니다.

또 다각도로 접근하여, 로컬 저장소를 사용해야 하는 이유에 대해서도 생각해보았습니다.

Firebase는 인터넷 연결이 끊겼을때 로컬의 캐시를 사용하고, 연결이 되면 이를 서버의 데이터베이스와 연동을 하는데, 데이터의 변동이 있거나 많은 양의 데이터가 추가되거나 삭제되는 경우에도 이를 캐시용량이 데이터베이스를 충분히 커버할 수 있을지에 대한 의문이 들어서 로컬 저장소가 필요할 것 같은 생각을 했습니다. 

---

### 🤦🏻‍♀️ 고민한 점 🧐

Realtime Database vs Firestore 중에 어떤걸 선택해야 하는지 고민했습니다. 

Realtime Database

- 데이터를 하나의 큰 JSON트리로 저장합니다
- 복잡한 계층적 데이터를 정규화 시켜서 정리하기 쉽지 않다는 단점이 있습니다

Firestore

- 문서와 컬렉션으로 이루어져 있다. 각 문서에는 키-값 쌍이 들어있고, 작은 문서가 많이 모인 컬렉션을 저장하는데 최적화되어있습니다
- NOSQL이지만 SQL처럼 테이블로 관리기에 용이하다는 장점이 있습니다.

Realtime Database 

<img src="https://i.imgur.com/5uWOkud.png" width="50%" height="50%">

Firestore

<img src="https://i.imgur.com/xrJKk2B.png" width="50%" height="50%">



Realtime Database가 서비스 기간이 더 오래되었지만 Firestore가 업그레이드 된 후속작이라는 글을 읽고 `Firestore`를 사용하기로 결정했습니다.
