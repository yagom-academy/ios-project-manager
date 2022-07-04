# 💻 프로젝트 매니저

## 프로젝트 적용기술 선정
### 설계 기술 스택
- RxSwift
- RxCocoa

### app 구조
- MVVM
- Clean Architecture

### 의존성 관리 도구
- SPM

### Local DB 기술 선정
#### SQLite
* 테이블 지향 관계형 데이터베이스(Relational database)
* thread-safe <- 원자성 동작(atomic)
* XML 데이터 저장 가능
* 동시 읽기는 빠르지만, 동시 작성은 불가능
* date 형식이 없음

#### CoreData
* 테이블 지향 관계형 데이터베이스(Relational database)
* in-memory 라서 로딩된 데이터 수정만 가능
* 원격에서 사용 불가
* 독립적으로 작성되어 재사용 및 유지보수가 편리
* thread-safe 하지 않음

#### Realm
* Object-oriented database
* NoSQL(Not Only SQL)
* Thread 관리 필요
* 모바일 환경, 주로 안드로이드에 맞게 설계됨

### Remote DB 기술 선정
#### iCloud
* 테이블 지향 관계형 데이터베이스(Relational database)
* 사용자가 추가적인 사용료를 부과할 수 있음
* iCloud의 서버가 포화 상태일 때 동기화가 느릴 수 있음

#### Dropbox
* 데이터 보안성, 안정성 면에서 큰 장점
* 사용 가능한 이모지가 적다.
* 유료 서비스
* 동시 연결 기기 수 3개로 제한

#### Firebase
* RTSP(Real Time Stream Protocol) 방식 -> 실시간으로 데이터들을 전송
* 관리자 페이지 제공
* 앱 사용 통계 정보 제공
* 서버가 해외에 있을 때 종종 처리 속도 느림
* 데이터 검색이 어렵다 -> 앱에서 모든 데이터 받아서 필터링 필요

#### MongoDB
* 방대한 데이터를 빠르게 처리 가능
* CASCADE가 불가능 -> 수정이 잦은 app에는 적합하지 않음

---

## 기술 선택
- local: coredata
- remote: firebase

## 고민 포인트
* 하위 버전 호환성에는 문제가 없는가?
    - coredata: iPadOS 3.0+
    - firebase: iPadOS 10.0+

* 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
    - cocoaPod

* 이 앱의 요구기능에 적절한 선택인가?
    - firebase: 수정된 데이터 처리, 관리자 페이지 제공 / 데이터 필터링이 요구되지 않아 단점이 보완된다.
    - coredata: 독립적으로 작성되어 재사용 및 유지보수가 편리
