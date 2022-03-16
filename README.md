# 🏁프로젝트 관리 앱

## About...

### contributors
👩🏻‍💻개발 @yeahg-dev

🙌🏻리뷰어 @lina0322

### schedule
2022년 2월 28일 ~ 2022년 2월 13일

### commit message convention
Karma스타일을 기본으로 `project`타입 추가

- feat : 새로운 기능 추가 
- fix : bug fix 
- docs : 문서 수정 
- style : 코드의 스타일 변화
- refactor : 리팩터링
- test : 테스트 코드 추가. 수정
- chore : 중요하지 않은 일
- project : Xcode project, info-plist 설정

### Tech  stack

구분 | 적용 기술
:---: | :---:
아키텍처 | MVC
UI | UIKit
Local DB | Core Data
Cloud DB | Firestore, FirebaseAuth, FirebaseAnaylitcs   
의존성 관리 툴 | SPM

<br>

## STEP 1️⃣ 
### 🙌🏻 PR
[STEP1 PR](https://github.com/yagom-academy/ios-project-manager/pull/80)

<br>

### 📝 학습 개념
- DB 구현 위한 다양한 라이브러리 및 프레임워크 분석
- Xcode의 project와 target의 개념과 차이점

<br>

### ✅ 로컬 DB, 클라우드 DB 구현을 위한 기술 스택 선정
구분 | 적용 기술
:---: | :---:
로컬 DB | Core Data
클라우드 DB | Firebase - Firestore

#### 선정 이유 -  Firestore

- Cloud와 실시간 동기화를 제공합니다.
- 다양한 기술을 지원합니다 (PushNotification, Analytics...)
- 클라이언트 접속 상태를 지원합니다.
클라이언트 연결 상태를 기록하고 클라이언트의 연결 상태가 변경될 때마다 업데이트를 제공할 수 있습니다. (realtimeDatabase와 함께 사용시 가능)
- 컬렉션으로 정리된 document 단위로 데이터 관리를 합니다. 계층적 데이터를 구조화하기엔 document 방식이 더 용이하고, 확장성이 좋을 것 같아 JSON트리로 데이터를 관리하는 realtime database 대신 firestore를 선택했습니다.
- Firestore외 FirebaseAuth, FirebaseAnaylitcs를 추가적으로 설치함으로서 인증을 위한 구현 비용을 줄이고, 사용자 앱 사용에 대한 데이터를 모니터링이 가능해졌습니다.

#### 선정 이유 -  Core data
2. Core Data
- 애플의 first-party 프레임워크로 안정적으로 사용이 가능합니다.
- NSFetchedResultController 와 함께 사용하여 데이터 변화에 따른 뷰의 동기화를 처리할 수 있습니다.

Firestore가 앱에서 자주 사용하는 데이터를 캐싱함으로서 오프라인 데이터 접근성을 지원한다고하여, LocalDB도 Firestore로 구현할까 고민이 되었었습니다. 그런데 로컬 캐싱의 메모리는 제한적이므로 데이터가 삭제될 수 있는 리스크가 있을거라 생각했습니다. 오프라인에서도 안정적인 사용성을 지원하고 싶어 LocalDB는 CoreData로 따로 구현하게 되었습니다.

<br>

### 🤔 고민한 점
**1. 이 앱의 요구기능에 적절한 선택인가?**

Firestore: 리모트와 실시간 동기화를 지원합니다. 더불어 프로젝트를 여럿이 공유할 경우, 여러 사용자가 동시에 접근하여 데이터를 수정 관리 가능합니다.

Coredata: persistence data를 저장하기 위한  애플의 프레임워크로 로컬 DB를 구현하기에 적합합니다.

**2. 하위 버전 호환성에는 문제가 없는가?**

Firestore: iOS10 이상 지원하고 있으며, [2022년 기준 OS점유율](https://developer.apple.com/kr/support/app-store/)로 보았을 때 무리없이 하위 버전의 OS와 호환이 가능할 것이라 판단했습니다. (타겟 버전은 14.0으로 설정했습니다)

Coredata: iOS 3.0 이상 지원하므로 문제 없습니다!

**3. 안정적으로 운용 가능한가?**

Firestore: 구글이 운영하는 라이브러리로 현재 많은 기업에서 사용하고 있는 것으로 알고 있습니다.

Coredata: iOS의 first-party DB이므로 iOS와 운명을 함께 합니다.

**4. 미래 지속가능성이 있는가?**

Firestore: 현재에도 꾸준하게 업데이트 되고 있는 라이브러리로, 앞으로도 개선, 유지보수가 될 것이라 생각합니다.

Coredata: 애플이 제공하는 Framework로 WWDC와 함께 꾸준히 업데이트될 것이라 생각합니다.

**5. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?**

Firebase: NoSQL DB로 쿼리가 빈약하여 데이터 검색이 어렵다는 글들을 보았습니다. 빅데이터를 관리해야하는 서비스의 경우 불편함이 있을 수 있으나, 이번 프로젝트의 경우 간단한 쿼리만 사용될 것이라 생각하여 포용가능 할 것 같습니다.

Coredata: 아직 찾지 못하였습니다

**6. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?**

Firebase: Cocoapods, SPM, Carthage으로 사용할 수 있습니다. 이전 프로젝트에서 Cocoapod을 사용해본 적이 있어서, first-party인 도구를 사용해보고 싶어서 SPM을 선택했습니다.

