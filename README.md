# 프로젝트 관리 앱 저장소

### 프로젝트 적용 기술 선정

언어는 `swiftUI`와 디자인 패턴은 `MVVM`을 DB는 `CoreData + Firebase`을 선택하였습니다.
MVVM 디자인 패턴을 적용해보고 싶었고 swiftUI가 MVVM패턴을 적용하는데 매우 유리하다라고 공부를 하였기 떄문입니다.
이번 프로젝트에서 핵심적으로 공부하고 싶은 부분은 MVVM입니다.

CoreData + Firebase(실시간 데이터베이스)로 선택한 이유는 다음과 같습니다.

- CoreData로 LocalDB를 설정하면 First Party이므로 안정성 및 미래 지속가능성도 높기에 RemoteDB를 상황에 맞게 변경할수 있는 장점이 있어 선택하였습니다.
- Firebase는 인증, Realtime DataBase, Firebase ML등 다양한 기능을 제공하고 있어 확장에 유리하다고 생각을하였습니다.
- 실시간 동기화(Realtime DataBase)를 하면 팀내부에서 사용할때 매우 용이할것 같다고 생각이 들었습니다. 또한 이번 프로젝트에서는 [복잡한 쿼리](https://firebase.google.com/docs/database/rtdb-vs-firestore)가 필요할것 같지도 않았구요


### 고민 포인트

- 하위 버전 호환성에는 문제가 없는가?
    - CoreData는 ios 3.0+ 
    - Firebase는 ios 10+
    - swiftUI를 사용하면 iOS13.0+
    - swiftUI를 선택하면 하위버전에 호환성은 낮다고 볼수 있으나 [ipadOS 전체88%](https://developer.apple.com/kr/support/app-store)가 13이상이여서 괜찮다고 생각이 들었습니다. 
    - DB의 구조가 바뀌었을때는 CoreData에서는 버전을 추가하여 새로운 모델을 만들고 마이그레이션을 통한 동기화를 하면될것 같습니다.
    
- 안정적으로 운용 및 미래 지속가능성이 있는가?
    * Firebase Third Party로 구글에서 운용하고 있지만, 지속적으로 [github](https://github.com/firebase/quickstart-ios)에 지속적으로 업데이트 되고 있고 LocalDB는 CoreData를 사용하고 있기에 RemoteDB는 상황에 맞춰서 가면되어 안정적으로 운용 및 미래 지속가능성이 높다고 생각합니다.
    
- 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
    - CoreData는 Thread safe 하지않습니다.
    - Firebase는 서버에 문제가 생기면 동기화에 문제가 생길수도 있습니다.
    - 현재 프로젝트에서는 무관하나 Firebase는 NoSQL DB만 제공하므로 데이터 중복에 대한 문제가 있습니다.
    
- 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
    * Firebase 홈페이지 설명에서 cocoaPods 또는 SPM으로 설치 가능한것으로 확인하였습니다.
    * CoreData는 의존성 관리도구가 필요없습니다.
    
- 이 앱의 요구기능에 적절한 선택인가?
    - CoreData를 사용하면 메모리 로드시 다양한 방식으로 구현할수 있습니다.
    - Firebase를 통하여 RealTimeDB나 FireStoreDB를 구현할수 있고, 인증 등 확장에 용이하기에 적절한 선택이라고 할수 있을것 같습니다.

