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
|CoreData|저장된 기록을 SQLite보다 빠르게 가져온다|SQLite 보다 많은 메모리를 사용하고,더 많은 저장공간이 필요하다|
|Realm| CoreData보다 빠르고, 훨씬 간단하게 사용가능 | 서드파티 라이브러리|

## Remote DB

||장점|단점|
|:---:|:---:|:---:|
|Firebase| DB 뿐만아니라 Firebase Authentication, Google Analytics 등 다양한 기능을 제공함|서버가 해외에 있기 때문에 상대적으로 느릴 수 있음|

## 기타

### SnapKit

- translatesAutoresizingMaskIntoConstraints = false 를 신경쓰지 않아도 됨
- 편의성을 위해 사용

### CombineCocoa

- UIKit과 Combine을 쓸때, CombineCocoa가 없다면, 코드가 깔끔하게 작성되지 않음
- 편의성을 위해 사용


## 적용기술 선정 및 근거
### 적용 기술 선정
| Local DB | Remote DB | UI | 비동기 이벤트 처리 | Layout | Convention | 의존성 관리 도구 |
|---|---|---|---|---|---|---|
| Realm | Firebase | CombineCocoa | Combine | SnapKit | SwiftLint | CocoaPod |

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

#### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

- Firebase: 프로젝트가 커졌을 경우 프로젝트관리 / 과금 정책등 불편할 수 있음
- Realm: 유료화가 진행될 수 있다

#### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?

- Firebase: CocoaPods, Swift Package Manager
- Realm: CocoaPods, Carthage, Swift Package Manager
- CombineCocoa: CocoaPods, Swift Package Manager
- SnapKit: CocoaPods, Swift Package Manager
