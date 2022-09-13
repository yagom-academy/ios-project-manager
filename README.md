# 🗂 프로젝트 관리

## 🪧 목차
- [📜 프로젝트 및 개발자 소개](#-프로젝트-및-개발자-소개)
- [⚙️ 개발환경 및 라이브러리](#%EF%B8%8F-개발환경-및-라이브러리)
- [⏰ 타임라인](#-타임라인)
- [📱 구현 화면](#-구현-화면)
- [👩🏻‍💻 코드 설명](#-코드-설명)
- [📁 폴더 구조](#-폴더-구조)
- [⚡️ 트러블 슈팅](#%EF%B8%8F-트러블-슈팅)
- [🔗 참고 링크](#-참고-링크)


<br>

## 📜 프로젝트 및 개발자 소개
> **소개** : 프로젝트 할 일을 `TODO`-`DOING`-`DONE`으로 구분하여 관리할 수 있는 iPad 가로모드 전용 앱 
> **프로젝트 기간** : 2022.09.05 ~ 2022.09.16 
> **리뷰어** : **라자냐**(@wonhee009)

| **주디(Judy)** |
|:---:|
<img src="https://i.imgur.com/n304TQO.jpg" width="300" height="300" />|
|[@Judy-999](https://github.com/Judy-999)|

<br>

## ⚙️ 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]() [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]() [![img](https://img.shields.io/badge/Firebase-Firestore-red)](https://firebase.google.com/products/firestore?hl=ko) [![SwiftLint](https://img.shields.io/badge/SwiftLint-SwiftLint-yellow)]()

<br>

## ⏰ 타임라인

<details>
<summary> 1주차 </summary>

- 22.09.05 : 프로젝트 기술 선정 
- 22.09.06 : 프로젝트에 라이브러러리 적용
- 22.09.07 : 스텝 세분화, RxSwift 및 MVVM 공부
- 22.09.08 : View 코드 구현, 테이블 뷰에 rx로 데이터 채우기

</details>
	

<details>
<summary> 2주차 </summary>

- 22.09.13 : MVVM 구조 적용하는 리팩토링 및 PR 제출 


</details>

<br>

## 📱 구현 화면

**메인 화면**

<img src = "https://i.imgur.com/GpXZ0iz.png" width="480" height="350">
<br>

**할 일 상세보기 및 생성**

![](https://i.imgur.com/Ke9bPZc.gif)

<br>

**지역별 날짜 표현**


| US로 설정한 메인화면 | US로 설정한 상세화면 | 
| -------- | -------- |
|  ![](https://i.imgur.com/nMvbIaa.png)|  ![](https://i.imgur.com/YT0Og7E.png) |

<br>

## 👩🏻‍💻 코드 설명
**Model**
- `Work` : 해야 할 일을 나타내는 모델 타입 [title, content, deadline]
- `SampleData` : UI 구현을 확인하기 위한 샘플 데이터를 담은 타입
<br>

**View**
- `ProjectManagerView` : [TODO, DOING, DONE]의 테이블 뷰를 가진 메인 화면에 보여지는 뷰
- `HeaderView` : [TODO, DOING, DONE]의 타이틀과 현재 셀 개수를 나타내는 뷰
- `WorkTableViewCell` : 할 일의 내용을 표현하는 테이블 뷰 셀
- `WorkManageView` : 할 일의 세부정보를 표현하거나, 새로운 할 일을 추가하는 뷰
<br>

**ViewModel**
- `WorkViewModel` : 상태별 할 일의 데이터를 가지고 변경을 담당
<br>

**Extension**
- `Date` 
	- `convertToRegion` : 지역에 따른 날짜 형식으로 변경하는 메서드
	- `checkOverdue` : 오늘 날짜와 비교해 기한이 지났는지 판단하는 메서드
- `UIView`
	- `applyShadow` : 테두리에 그림자 효과를 넣어주는 메서드
<br>

## 📁 폴더 구조
```
.
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base.lproj
├── Extension
│   ├── Date+Extension.swift
│   └── View+Extension.swift
├── Info.plist
├── Model
│   ├── SampleData.swift
│   └── Work.swift
├── Resources
│   ├── Assets.xcassets
│   └── Base.lproj
│       └── LaunchScreen.storyboard
├── View
│   ├── HeaderView.swift
│   ├── ManageWorkViewController.swift
│   ├── ProjectManagerView.swift
│   ├── ProjectManagerViewController.swift
│   ├── WorkManageView.swift
│   └── WorkTableViewCell.swift
└── ViewModel
    └── WorkViewModel.swift
```

<br>

## ⚡️ 트러블 슈팅

### 1. 기술 선정 
**[ LocalDB - CoreData ]**
- 기본으로 제공되는 데이터 저장용 프레임워크
- 프로젝트에 Volum을 키우지 않음
- SQLite를 저장소로 사용
- Entity를 추가하고 모델 파일을 만들어 모델 객체를 사용
<br>

<details>
<summary>이외 다른 Local DB의 특징</summary>
	
### SQLite
- 비교적 가벼운 데이터베이스
- 대규모 작업에는 적합하지 않음
- 데이터를 저장하는 데 하나의 파일만 사용
- iOS에 이미 내포되어 있어 라이브러리를 사용하지 않아도 됨
<br>
	
### Realm
- 모바일을 타깃으로 한 DBMS
- 속도가 빠르고 대용량 데이터를 다룰 수 있음
- 객체 중심 데이터베이스
- 지원 버전: iOS 8 또는 OS X 10.9 이상
- 무료!
- [Realm Studio](https://realm.io/products/realm-studio)로 데이터를 실시간으로 검색 및 수정할 수 있음
- 현재 Realm은 NoSQL(Not Only SQL)의 대표주자인 MongoDB에 인수됨
- iOS와 Android 간 DB 공유가 가능
- RxRealm 

</details>
<br>

**[ RemoteDB - Firebase ]**
- 구글(Google)이 제공하는 모바일 애플리케이션 개발 플랫폼
- 클라우드 서비스인 동시에 백엔드 기능을 가지고 다양한 기능을 제공
 (분석, 인증, 데이터베이스, 구성 설정, 파일 저장, 푸시 메시지 등)
- 일정 사용량 이내에서는 무료
- 콘솔 제공
- 서버가 해외에 있기 때문에 응답속도가 느릴 수 있음
<br>

#### RealtimeBase vs Firestore
리모트 저장소로 선택한 `Firebase`에서는 `RealtimeBase`와 `Firestore` 두 가지 데이터베이스를 제공

|RealtimeBase | Firestore | 
| ------- | -------- | 
| - 클라우드 호스팅 데이터베이스<br>- 데이터는 JSON으로 저장<br>- 연결된 모든 클라이언트에 실시간으로 동기화<br>- Apple, Android 등 여러 플랫폼 공유 가능<br>- 주요 기능 : 실시간, 오프라인, 클라이언트 기기에서 엑세스 가능, 여러 데이터베이스에서 규모 조정 | - 유연하고 확장 가능한 데이터베이스<br>- 컬렉션으로 정리되는 문서 데이터로 저장<br>- 실시간 데이터베이스와 마찬가지로 실시간 동기화 및 다양한 플랫폼 지원<br>- 주요 기능 : 유연성, 표형형 쿼리, 실시간 업데이트, 오프라인 지원, 확장형 설계  |

<br>

`Firestore`가 `RealtimeBase`보다 이후에 나온 데이터베이스로 어느 정도 `RealtimeBase`의 단점을 보완한 상위호환된 버전의 느낌을 받았습니다. 실제로 `Firebase`의 단점으로 빈약한 쿼리가 자주 대두되었는데 `Firestore`는 보다 복잡한 쿼리가 가능하다. 이외에서 유연한 계층적 데이터 구조를 지원하고, 확장에 보다 열려있습니다.

`RealtimeBase`은 선택한다면 지연 시간을 조금 줄일 수 있고, 규모가 커져도 금액의 상승 폭이 덜 부담된다는 장점이 있습니다. 

하지만 저는 소규모 프로젝트이기 때문에 비용 측면은 고려 대상이 아니고, 지연 시간을 줄이는 것 보다 `Firestore`의 다른 장점을 이용하는 것이 이후 프로젝트에 확장성을 위해서도 좋을 것 같아 최종적으로 `Firestore`을 사용하기로 했습니다.
<br><br>

### 2. 라이브러리 경고
라이브러리를 적용한 후에 빌드를 하면 경고가 발생했습니다. 실행하는 것엔 문제가 없지만 분량이 많아 프로젝트 관리상 좋지 않고, 필요한 경고를 볼 수 없어 제거하기로 했습니다.
<br>

| `IPHONES_DEVELOPMENT_TARGET` 경고 | `gRPC-Core` 경고 | 
| -------- | -------- | 
| ![](https://i.imgur.com/JQuvod2.png)| <img src = "https://i.imgur.com/2EAwEkz.png" width="500" height="400">| 

<br>

첫 번째는 특정 라이브러리의 타켓이 프로젝트의 타겟과 맞지 않아서 발생하는 문제로 수동으로 설정하면 이후에 `pod install` 하면 다시 돌아가기 때문에 Podfile에 아래 코드를 추가해야 한다.
<br>

```swift
post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
```
<br>

Ruby 언어로 `installer`에서 프로젝트 설정을 불러와 다시 설정을 타겟을 '9.0'으로 덮어씌워 경고를 해결할 수 있습니다.
<br>

두 번째는 **Firebase**를 적용한 후 발생한 경고로 **Firebase**에 포함된 라이브러리에서 발생한 경고입니다. 최신 버전에서 발생한 오류로 firebase-ios-sdk 버전을 낮추거나 **Firebase**에서 해결해주기를 기다려야 합니다. 실행에도 문제 없고 본인 프로젝트에서 발생한 문제가 아니므로 Podfile에 라이브러리의 경고를 무시하도록 하는 `inhibit_all_warnings!` 문구를 추가하여 해결했습니다.


<br>

### 3. 기한 비교
오늘을 기준으로 기한이 지난 할 일의 날짜는 빨간색으로 표시해야 해서 `Date`를 extension하여 기한 지남 여부를 `Bool` 값으로 반환하는 `checkOverdue` 메서드를 구현했습니다. 처음에는 단순히 `Date()`와 대소비교를 하였는데, 오늘 날짜여도 시간이 지났으면 기한이 지났음으로 표시되는 문제가 있었습니다. 시간에 대한 기한 설정은 없으므로 날짜로만 비교하는게 맞다고 생각해 대소비교와 함께 오늘 날짜인지 비교하는 로직을 추가했습니다.
<br>

```swift
func checkOverdue() -> Bool {
    let today = Date().convertToRegion()
    let dateToCompare = self.convertToRegion()
        
    return today != dateToCompare && Date() >= self
}
```
<br>

시간을 제외하고 날짜가 오늘과 같은지 비교하는 다양한 방법이 있지만 간단하게 미리 구현했던 `convertToRegion` 메서드로 `String`으로 변경된 날짜가 같은지 비교하는 방식으로 했습니다.
<br>

## 🔗 참고 링크

<details>
<summary>[STEP 1]</summary>
	
[위키백과-SQLite](https://ko.wikipedia.org/wiki/SQLite)<br>[CoreData와 Realm](https://agilie.com/blog/coredata-vs-realm-what-to-choose-as-a-database-for-ios-apps)<br>[Realm 공식 홈페이지](https://realm.io)<br>[Realm이란 무엇인가?](https://hellominchan.tistory.com/27)<br>[Core Data](https://developer.apple.com/documentation/coredata)<br>[Firebase](https://firebase.google.com/docs/ios/setup?hl=ko)<br>[데이터베이스 선택: Cloud Firestore 또는 실시간 데이터베이스](https://firebase.google.com/docs/database/rtdb-vs-firestore?hl=ko)<br>[Firebase Realtime, Cloud Firestore](https://iamthejiheee.tistory.com/246)
	
</details>

<details>
<summary>[STEP 2]</summary>
	
[gRPC-cpp and gRPC-Core Value conversion build warnings](https://github.com/firebase/firebase-ios-sdk/issues/9790)<br>[CocoaPods 프로젝트에서 시뮬레이터 타겟 관련 워닝](https://bonoogi.postype.com/post/8832708)<br>[The iOS Simulator deployment target 'IPHONES_DEVELOPMENT_TARGET'](https://fomaios.tistory.com/entry/%ED%95%B4%EA%B2%B0%EB%B2%95-%ED%8F%AC%ED%95%A8-The-iOS-Simulator-deployment-target-IPHONESDEVELOPMENTTARGET-is-set-to-80but-the-range-of-suppoted-deployment-target-vesions-is-90-to-14499)<br>[Xcode 에서 Pod 프로젝트의 경고 표시 없애기](https://code.iamseapy.com/archives/174)<br>[shadow 그림자 효과 top, left, right, bottom 방향 주는 방법 ](https://ios-development.tistory.com/653)<br>[swift MVVM 정리 및 예제](https://42kchoi.tistory.com/292)

	
</details>

