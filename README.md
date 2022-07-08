# 🗓 프로젝트 매니저

> 프로젝트 기간: 2022.07.04 ~ 2022.07.15 <br>
> 팀원: [Donnie](https://github.com/westeastyear), [grumpy](https://github.com/grumpy-sw)
> 리뷰어: 🍕[라자냐](https://github.com/wonhee009)

# 📋 목차
- [프로젝트 소개](#-프로젝트-소개)
- [프로젝트 실행화면](#-프로젝트-실행화면)
- [타임라인](#-타임라인)
- [PR](#-pr)
- [STEP 1](#step-1)
    + [적용 기술 선정 및 근거](#-적용-기술-선정-및-근거)

<br>

## 🔎 프로젝트 소개
### "할건 많고 시간은 부족한 당신! 🫵🏻"
### "매니저가 필요해 보이는군요?!" 
### "Project Manager로 해야할 일을 손쉽게 관리해보세요!"

<br>

## 📺 프로젝트 실행화면


<br>

## ⏱ 타임라인
|날짜|내용|
|--|--|
|22.07.04(월)|프로젝트 적용 가능한 기술 조사|
|22.07.05(화)|STEP1 PR|
|22.07.06(수)|STEP1 피드백 반영|
|22.07.07(목)|STEP2-1 진행|
|22.07.08(금)|STEP2-1 진행|
    
## 👀 PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/124)


## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-14.0-red)]()

## 🔑 키워드
- RxSwift
- RxCocoa
- RxRelay
- Firebase
- Realm
- SnapKit
- SwiftLint
- Swift Package Manager
- Cocoapod

---

## [STEP 1]
## 적용 기술 선정 및 근거
|Reactive|UI 구현|로컬 DB|원격 DB|Convention|Layout|
|:---:|:---:|:---:|:---:|:---:|:---:|
|RxSwift|RxCocoa|Realm|Firebase|SwiftLint|SnapKit|

### RxSwift
- `Swift`로 `Reactive` 프로그래밍을 하기 위해 선택
- 비동기적으로 움직이는 이벤트들을 직관적, 효율적으로 코드를 작성하기 위함

### RxCocoa
- `Cocoa Framework에 Rx(ReactiveX)` 기능을 결합한 라이브러리
- `UI`구성요소에 반응형 확장 기능을 추가하여 `UI`이벤트 추가 가능

### Realm
`Realm` vs `CoreData`
1. 데이터베이스 사용 면에서 `Realm`이 `CoreData`보다 사용하기 쉽다.
2. `Realm`이 `CoreData`보다 모델을 관리하기 쉽다.
3. `third-party` 라이브러리이기 때문에 `Realm`을 사용했을 때 앱의 용량이 커진다.
4. `CoreData`는 `Realm`과 다르게 `cross-platform mobile device`가 아니다.

위 이유로 로컬 DB를 관리하는 기술로 `Realm`을 선정

### Firebase 
||`RealTime Database`|`Cloud Firestore`|
|:---:|:---:|:---:|
|**특징**|데이터를 하나의 큰 JSON 트리로 저장|데이터를 문서와 컬렉션으로 저장|
|**장점**|지연 시간이 짧아 동기화가 자주 발생할 때 유리하다.|풍부하고 빠른 쿼리<br>원활한 확장성|
|**단점**|데이터의 크기가 성능에 영향을 준다.<br>확장이 어렵다.|요청 쿼리 결과에 따라 성능에 영향을 줄 수 있다.|

- 비록 `Cloud Firestore`가 후속으로 나온 제품이지만 다음과 같은 부분에서는 아직까지 강점을 보이고 있다고 생각해서 `Realtime Database`를 선택
    - 잦은 데이터 동기화
    - 작은 단위의 데이터가 자주 변경
    - 데이터 형식이 간단한 json 트리
    - CRUD 작업이 자주 발생


### SwiftLint
- 협업 시 공통적인 코딩 컨벤션으로 코드를 작성하기 위해 선택

### SnapKit
- 짧은 코드로 `AutoLayout`을 표현할 수 있도록 도와주는 프레임워크
- `AutoLayout` 설정 시 작성해야 하는 `Constraints` 관련 코드들을 줄일 수 있음
- 잘 만들어진 프레임워크를 사용함으로써 `Layout`에 대응하는 시간을 줄이고, 보다 더 중요한 로직을 구성하는데 시간을 집중하기 위해 선택
