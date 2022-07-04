# ⚒ 프로젝트 관리 앱

> 프로젝트 기간: 2022.07.04 ~ 2022.07.15 <br>
> 팀원: [마이노](https://github.com/Mino777), [두두](https://github.com/FirstDo)
> 리뷰어: [스티븐](https://github.com/stevenkim18)

# 📋 목차
- [프로젝트 목표](#-프로젝트-소개)
- [팀원](#-팀원)
- [프로젝트 실행화면](#-프로젝트-실행화면)
- [UML](#uml)
- [타임라인](#-타임라인)
- [PR](#-pr)
- [STEP 1](#step-1)
    + [고민한 점](#고민한-점)
    + [질문사항](#질문사항)

## 🔎 프로젝트 소개

## 👨‍👦‍👦 팀원


## 📺 프로젝트 실행화면


## ⏱ 타임라인
|날짜|내용|
|--|--|

    
## 👀 PR


## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-14.1-red)]()

## 🔑 키워드

---

## [STEP 1]
# 프로젝트 적용기술 선정

## Local DB
||장점|단점|
|:---:|:---:|:---:|
|CoreData|firstParty, 저장된 기록을 SQLite보다 빠르게 가져온다|SQLite 보다 더 많은 메모리를 사용하고,더 많은 저장공간이 필요하다. iOS환경에서만 사용가능 |
|Realm|빠르고, CoreData보다 훨씬 간단하게 사용가능, 크로스 플랫폼 지원|thirdParty 라이브러리리|

- https://cocoacasts.com/core-data-or-realm
- https://realm.io/best-ios-database/#faq

> Realm is a fast, reactive, and scalable alternative to SQLite that makes storing, syncing, and querying data simple for modern mobile applications.
>
> Realm is an open source, fast, scalable alternative to CoreData and SQLite that makes storing, syncing, and querying data simple for modern iOS applications.

## Remote DB

FireBase 문서에서 RealTime DB와 Cloud Firestore을 선택하는 기준이 있어서 확인해봤습니다.
이번 프로젝트는 다음과 같습니다
- 고급 쿼리, 정렬, 트랜잭션이 필요하지 않습니다
- 소규모 업데이트 스트림을 보냅니다 
- 간단한 JSON 데이터를 저장합니다

그래서 `RealTime DB`를 선택하기로 결정했습니다

## 기타 라이브러리

|SnapKit|CombineCocoa|
|:---:|:---:|
| AutoLayout을 설정할때, 기존에는 작성해야하는 코드양이 꽤 많았는데, SnapKit을 사용하면 Constraints들을 한번에 묶어서 설정할 수 있어서 코드양을 줄일수 있음 | UIKit의 UI들은 publisher가 아니기 때문에 이벤트들을 방출하지 않음. CombineCocoa를 사용하면, UI요소들에 Publisher들을 추가해서 이벤트를 구독할 수 있음|

## 적용기술 선정 및 근거

### 적용 기술 선정

|LocalDB|RemoteDB|UI|비동기이벤트처리|Layout|Convention|의존성관리도구|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|Realm|RealTimeDB|CombineCocoa|Combine|SnapKit|SwiftLint|CocoaPod|

### 적용기술 선정 근거

#### 1. 하위 버전 호환성에는 문제가 없는가?

- Firebase: iOS 10 이상
- Realm: iOS 8 이상
- Combine: iOS 13 이상
- CombineCocoa: iOS 13 이상

지난 4년 동안 도입된 기기의 89%가 iOS 15를 사용하고 있음
프로젝트의 타겟을 iOS14 이상으로 설정할 것이므로 문제가 없음

#### 2. 안정적으로 운용 가능한가?

- Firebase: 구글에서 운영, 대중적이기에 레퍼런스가 많음
- Realm: 작업 속도가 빠르고, Realm Studio(GUI) 등의 편의성, MongoDB가 운영
- Combine: 애플이 공식지원하는 라이브러리
- CombineCocoa: 메인스트림인 CombineCommunity 에서 운영

#### 3. 미래 지속가능성이 있는가?

- Firebase: 구글이 지원
- Realm: 최근 MongoDB가 인수하면서 지속가능성이 늘어남
- Combine: 애플이 공식지원하고, 앞으로 많이 쓰일일만 남음
- CombineCocoa: UIKit + Combine 자체가 드물고, UIKit -> SwiftUI 바뀌기 때문에 나중에는 거의 사용하지 않을것 같다

#### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

- Firebase: 프로젝트가 커졌을 경우 프로젝트관리 / 과금 정책등 불편할 수 있음
- Realm: 사용해보지 않았기 때문에 학습을 해야함 / 추후 유료화가 진행될 수 있다
- Combine: 없음
- CombineCocoa: 커뮤니티가 작고, RxCocoa에 비해서 부실함

#### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?

사용하는 모든 라이브러리가 CocoaPods을 지원함
SwiftLint가 SPM를 지원하지 않기때문에 무조건 `CocoaPods`을 써야함
