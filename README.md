# 프로젝트 매니저
## 기술스택 선정

### [ DataBase ]

- [ ] SQLite
- [ ] CoreData
- [ ] iCloud
- [ ] Dropbox
- [x] FireBase
- [x] Realm
- [ ] MongoDB

**고려사항 :**
1. 하위 버전 호환성에는 문제가 없는가?
    - Realm : ios 8.0 버전 이상 지원
    - Firebase : ios 10 버전 이상 지원
    - 현재 도입된 기기의 80% 정도가 ios 15버전을 사용하고 있다는 통계가 있으므로 문제가 없다고 판단했습니다.
    - [ios사용현황 통계](https://developer.apple.com/kr/support/app-store/)
3. 안정적으로 운용 가능한가?
    - Realm : 안정성을 위해 하나의 쓰레드에서 작업하도록 설계되었습니다.
    - Firebase : 실시간 보고서를 통해 안정성 파악이 가능합니다.
    [firebase고객센터글](https://support.google.com/firebase/answer/7570091?hl=ko)
5. 미래 지속가능성이 있는가?
    - 두 플랫폼 다 이미 많은 사용자를 확보했으므로 지속가능성이 충분히 있다고 판단했습니다.
7. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
    - Realm : Thread 문제 - `ThreadSafeReference` 키워드를 이용하여 해결할 수 있습니다.
      [참고 블로그](https://hururuek-chapchap.tistory.com/210)
    - Firebase : 서버의 응답속도, 쿼리 빈약 - 이번 프로젝트에서 복잡한 쿼리문이 쓰일 필요가 없기 때문에 상관 없을 것이라 판단했습니다.
    [참고 블로그](https://velog.io/@haujinnn/FireBase)
8. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가? 
    - Realm : Cocoapod
    - Firebase : Cocoapod
9. 이 앱의 요구기능에 적절한 선택인가? 
    - remote Notification의 경우 firebase로 처리하고, local Notification 와 데이터관리에 realm을 사용하면 적절할 것이라고 판단했습니다.

 
### [ UI ]

 - [x] UIKit
 - [ ] SwiftUI
 - [ ] RxCocoa

**고려사항 :**

1. 근간이 되는 UIKit을 조금 더 공부 해보고자 선택했습니다.
### [ Design Pattern ]
- [ ] MVC 
- [ ] MVP
- [x] MVVM

**고려사항 :**

1. ViewController의 비대를 방지하고 효율적으로 구조를 분리 해보고자 MVVM 패턴을 선택했습니다.

