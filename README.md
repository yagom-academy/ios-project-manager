# 📋 프로젝트 매니저
## 프로젝트 소개
- 프로젝트 관리 앱 (iPad 가로모드 전용)을 구현합니다.
- Local DB는 Realm, Remote DB는 Firebase (FireStore)를 활용하여 데이터를 동기화했고, 의존성 관리도구로 SPM을 사용했습니다.
- RxCocoa 및 MVVM을 적용했습니다.
- 프로젝트 진행 상태를 TODO / DOING / DONE으로 구분할 수 있고, 기한이 초과된 작업은 빨간색으로 표시합니다.

### 참여자
- 리뷰어 : hyunable @hyunable
- 리뷰이 : applecider @just1103

### 프로젝트 기간 
- 2022.02.28 - 2022.03.11 (총 2주)

## 목차
- [STEP1. 프로젝트 적용기술 선정](##STEP1.-프로젝트-적용기술-선정)
    + [구현 내용](#1-1-구현-내용)
    + [기술스택 고려사항](#1-2-기술스택-고려사항)
    + [피드백 반영](#1-3-피드백-반영)
    + [키워드](#1-4-키워드)

# STEP1. 프로젝트 적용기술 선정
## 1-1 구현 내용
Local 및 Remote 데이터 동기화 기능을 구현하기 위해 기술스택을 선정했습니다.

### Local DB 비교
|DB|[Realm ✅](https://github.com/realm/realm-swift)|[SQLite](https://github.com/sqlite/sqlite)|[CoreData](https://developer.apple.com/documentation/coredata)|
|-|-|-|-|
|특징|- 모바일에 최적화된 *NoSQL DB 라이브러리로 가장 최근에 등장함</br>*NoSQL (Not Only SQL) : SQL 외 여러 유형의 DB를 사용함</br>- 데이터 객체가 Objective-C 클래스로 표현되며, 가볍고 반응형임</br>- *데이터 컨테이너 모델을 사용함</br>*컨테이너 : OS상의 논리적인 구획(컨테이너)을 만들고, 앱 실행에 필요한 라이브러리/앱을 하나로 모아, 별도 서버처럼 사용하도록 만든 구조. 컨테이너는 오버헤드가 적으므로 가볍고 속도가 빠름</br>- Swift, Objective-C, Java, Kotlin, C#, JavaScript 등의 SDK를 제공|- 전세계적으로 가장 많이 사용되는 SQL DB 라이브러리</br>- 전통적인 테이블 지향 관계형 DB</br>- *ORM 모델을 사용함 (🧐사용, 미사용 모두 가능한 구조일까요?)</br>*ORM (Object Relational Mapping) : OOP의 “객체” 및 관계형 DB의 데이터인 “테이블”을 매핑하는 구조</br>- [단일 사용자의 데이터를 저장하는 로컬 앱에 적합](https://smoh.tistory.com/368)|- 앱의 Model layer를 관리하기 위한 Apple의 First-party FrameWork (DB가 아님) </br>- Persistence 기능은 SQLite에 의해 지원됨 </br>- ORM 모델을 추상화한 구조
|장점|- [SQLite 및 CoreData 대비 작업 속도가 빠름](https://hackernoon.com/sqlite-vs-realm-which-database-to-choose-in-2021-8g1v3wf9)</br>- 하나의 앱에서 여러 DB를 사용 가능</br>- 데이터를 객체 형태로 저장하여 DB에서 가져온 데이터를 앱에 즉시 사용 가능하고, CoreData 코드를 Realm으로 Migration하기 용이함</br>- 데이터 저장 용량이 무제한/무료</br>- iOS 및 Android 간의 DB 공유 가능</br>- Realm Studio를 통해 Finder로 DB 확인이 쉬움</br>- CoreData 대비 직관적인 코드</br>- DB 처리에 Main Thread를 사용하므로 안정적임 (장점이자 단점)|- C언어로 작성되어 가벼우며, 전체 DB를 디스크 파일 1개에 저장</br>- 설정이 쉬움</br>- Thread-safe</br>- 다양한 OS에서 사용 가능 (MacOS X, iOS, Android, Window, Linux)|- 데이터를 객체 (NSManagedObject) 형태로 저장하여 DB에서 가져온 데이터를 앱에 즉시 사용 가능 </br>- SQLite 대비 속도가 빠름
|단점|- Thread-confined함 (스레드별 객체 관리가 필요. 다른 스레드로 전달하려면 wrapper 등이 필요)</br>- SQLite 대비 바이너리 용량이 큼</br>- 다양한 query를 지원하지 않음|- 동시성 (Concurrency)에 제한이 있음 (여러 프로세스가 DB에 접근/quering이 가능하지만, 한 번에 1개 프로세스만 처리 가능)</br>- 데이터 용량이 큰 경우 부적합</br>- 접근 권한 종류가 한 가지 밖에 없음|- 사용이 직관적이지 않고 번거로움 (Entity 생성, 코드로 데이터를 Read/Write 등)</br>- 메모리 및 저장공간 소모가 큼 (In-memory 방식은 메모리에 로딩된 객체만 수정 가능)</br>- 데이터 중복을 방지하는 unique key 기능이 없음</br>- Thread-unsafe</br>- 오버헤드 발생 가능</br>- Android 등 크로스 플랫폼을 지원하지 않음|

### Remote DB 비교
|DB|[Firebase (FireStore) ✅](https://github.com/firebase/firebase-ios-sdk)|[CloudKit](https://developer.apple.com/documentation/cloudkit)|
|-|-|-|
|특징|- Google에서 제공하는 모바일 앱개발 플랫폼 (오픈소스 아님)</br>- NoSQL DB 라이브러리</br>- 데이터 동기화를 사용해 연결된 모든 기기의 데이터를 업데이트함</br>- 데이터가 문서 Collection 형태로 저장됨</br>- 구조화된 JSON 및 Collection 데이터 처리에 적합|- 앱 및 사용자 데이터를 iCloud 서버 (container)에 저장하기 위한 Apple의 프레임워크</br>- Private/Shared/Public 등으로 DB Type을 구분</br>- Public DB 저장된 데이터는 전체 사용자가 접근 가능</br>- Private DB (사용자 데이터를 저장)에는 iCloud 계정이 필요|
|장점|- iOS, Android, 웹 등 크로스 플랫폼을 지원</br>- iCloud 보다 저렴함</br>- Google Analytics/Ads 연동이 쉬움</br>- 유연한 계층적 데이터 구조를 지원하여 복잡한 데이터 저장에 적합함</br>- 자주 사용되는 데이터를 캐시하므로 오프라인에서도 앱 데이터 쓰기/읽기/수신 대기/query 등이 가능 [(오프라인일 때 변경사항을 queue에 저장해두고, 온라인으로 전환됐을 때 서버의 변경사항과 비교하여 일괄 처리)](https://github.com/firebase/firebase-ios-sdk/blob/master/Firestore/core/src/local/local_store.h#L73)</br>- expressive한 query를 통해 복잡한 정렬/필터링이 가능 (단, query에서 항상 전체 문서를 반환해야 함)|- 간단한 데이터는 Key-Value 형태 (CKRecord)로 저장 가능</br>- File 형태로 데이터를 저장 가능 (iCloud 백업 사용 시 파일의 스냅샷이 업로드됨)</br>- CoreData와 연동이 용이함</br>- 데이터를 암호화할 수 있으며, 여러 OS (iOS, iPadOS, macOS, tvOS, watchOS 및 웹) 간 동기화가 원활함</br>- iCloud 계정을 사용하는 경우 별도의 인증 과정이 불필요함|
|단점|- Google에서 지원하므로 iOS 보다 Android에 최적화되어 있음 (ex. device testing 등)</br>- 데이터 저장용량이 제한적임 (무료 최대 1GB)</br>- 서버 구축 대비 속도가 느림|- Android 등 크로스 플랫폼을 지원하지 않음 (Apple의 JS library를 통해 다른 플랫폼에도 활용 가능하지만, iCloud 계정이 필요함)</br>- custom 이벤트를 추적하거나 해당 이벤트 기반의 사용자 정보를 생성할 수 없는 등 Analytics 데이터를 얻을 수 없음|

* Firebase의 DB 솔루션인 [FireStore 및 Realtime을 비교](https://firebase.google.com/docs/database/rtdb-vs-firestore?hl=ko)해봤는데, FireStore가 Realtime 대비 직관성/성능/확장성을 개선한 최신 기능이고, 특히 Realtime은 서버 확장이 자동 지원되지 않는다는 단점이 있으므로 FireStore를 사용했습니다.

## 1-2 기술스택 고려사항
1. 하위 버전 호환성에는 문제가 없는가?
    - Deployment Target을 iOS 13이상으로 설정할 계획이고, Xcode 버전 13.1을 사용 중이므로 문제 없습니다.
    - Realm : [SPM 사용 기준 iOS 11 이상](https://docs.mongodb.com/realm/sdk/swift/install/)
    - Firebase : [SPM 사용 기준 Xcode 12.5 이상, iOS 10 이상](https://firebase.google.com/docs/ios/setup?hl=ko)
2. 안정적으로 운용 가능한가?
    - Firebase : 3백만 개 이상의 어플에서 활용되는 안정화된 라이브러리입니다. 
    - Realm : 모바일에 최적화되어 있으므로 iOS를 지속 지원할 것으로 예상되며, [2.0 버전부터 안정화](https://www.theteams.kr/teams/859/post/64925)됐다고 판단했습니다.
3. 미래 지속가능성이 있는가?
    - Realm 및 Firebase 모두 지속적으로 기능이 업데이트되고 있습니다.
    - 서비스를 확장하여 Android 앱을 개발할 경우에도 두 라이브러리를 사용할 수 있습니다.
5. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
    - Realm 및 Firebase 모두 First-party 라이브러리가 아니므로 서비스가 중단될 리스크가 있지만, 중단될 가능성이 낮다고 판단했습니다.
    - Realm : Thread별 객체 관리가 필요하며, 바이너리 용량이 크므로 지속적으로 Thread/용량을 관리할 필요가 있습니다. 또한 현재 용량 무제한/무료이지만 가격 정책이 변경될 수 있습니다.
    - Firebase : 구조화되지 않은 JSON 데이터 처리에 적합하지 않으므로 데이터 형태를 관리해야 합니다. 또한 무료 데이터 저장용량이 제한적 (최대 1GB)이므로 용량 관리가 필요합니다.
6. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
    - Realm 및 Firebase 모두 Cocoa Pods, Carthage, SPM을 사용할 수 있습니다.
    - First-party 라이브러리인 SPM을 사용할 예정입니다.
7. 이 앱의 요구기능에 적절한 선택인가?
    - iPad 전용 앱이며, Deployment Target iOS 13 이상이므로 적절하다고 판단했습니다.

## 1-3 피드백 반영

## 1-4 키워드
- RxCocoa, Realm, Firebase (FireStore), SPM 
- 검토했던 라이브러리 : SQLite, CoreData, CloudKit, Dropbox 등
