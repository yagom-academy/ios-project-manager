# <img src = "https://hackmd.io/_uploads/B1r7f2cya.png" width = "35"> 프로젝트 매니저  <img src = "https://hackmd.io/_uploads/Bkf_435kT.png" width = "30"><img src = "https://hackmd.io/_uploads/rJhCN3qkp.png" width = "30">

- 프로젝트 기간: [2023년 9월 18일 ~ 10월 6일](https://github.com/WhalesJin/ios-project-manager/wiki/타임라인)
- 프로젝트 팀원: [Whales <img src = "https://hackmd.io/_uploads/Bkf_435kT.png" width = "20">](https://github.com/WhalesJin) , [Minsup <img src = "https://hackmd.io/_uploads/rJhCN3qkp.png" width = "20">](https://github.com/agilestarskim)
- 프로젝트 리뷰어: [GREEN🦚](https://github.com/GREENOVER)

---

## 📖 목차
🍀 [소개](#소개) </br>
💻 [실행 화면](#실행_화면) </br>
🛠️ [사용 기술](#사용_기술) </br>
👀 [다이어그램](#Diagram) </br>
🧨 [트러블 슈팅](#트러블_슈팅) </br>
📚 [참고 링크](#참고_링크) </br>
👩‍👧‍👧 [about TEAM](#about_TEAM) </br>

</br>

## 🍀 소개<a id="소개"></a>

<img src = "https://hackmd.io/_uploads/Bkf_435kT.png" width = "20"><img src = "https://hackmd.io/_uploads/rJhCN3qkp.png" width = "20"> : 하나의 프로젝트를 세분화하여 관리할 수 있는 어플리케이션입니다.
칸반보드를 사용하여 TODO, DOING, DONE으로 분류해 진행도를 한 눈에 확인할 수 있습니다.

</br>

## 💻 실행 화면<a id="실행_화면"></a>

| 기본 화면 |
| :--------: |
| <img src = "https://hackmd.io/_uploads/BJ0D4s5ya.png" width = "600"> | 

| 새 할 일 추가 |
| :--------: |
| <img src = "https://hackmd.io/_uploads/rJ83Ej9yp.png" width = "600"> |

</br>

## 🛠️ 사용 기술<a id="사용_기술"></a>
| 구현 내용	| 도구 |
|:---:|:---:|
|UI|SwiftUI|
|아키텍쳐|클린 아키텍쳐|
|디자인패턴|MVVM|
|로컬 데이터|Realm|
|리모트 데이터|Firebase|

</br>

## 👀 Diagram<a id="Diagram"></a>
### 📐 UML

<img src = "https://hackmd.io/_uploads/HkGA5h9y6.png" width = "900">

</br>

## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>

### 1️⃣ 기술스택 설정

#### 1. 뷰 드로잉 - SwiftUI
UIKit에 비해 다음과 같은 장점을 느껴서 SwiftUI로 선택하였습니다.
 - 뷰 그리기 간단하다.
 - 레이아웃 많이 시간 안 뺏김
 - 코드가 짧고 직관적이다.
 - 재밌다.

#### 2. 아키텍처 - 클린 아키텍처 + MVVM
프로젝트들의 코드를 보면 체계도 없는 것 같고, 복잡성이 많이 얽혀있는 느낌이라 이렇게 중구난방하지않고 규칙이 있거나 의존방향이 일정했으면 좋겠다는 생각을 했습니다.
이를 해결해주는 것이 의존성 규칙에 대한 얘기를 하는 `클린 아키텍처`라고 생각합니다. 클린 아키텍처는 이론적이고 추상적인 느낌이라 방법이 되게 다양해 보였고, 그 중에서도 저희는 MVVM을 접목해서
**클린 아키텍처를 기반으로 MVVM**을 구현해보았습니다.

#### 3. 로컬데이터 - Realm
CoreData에 비해 다음과 같은 장점들이 더 와닿아서 Realm으로 결정했습니다.
- 속도가 CoreData보다 훨씬 빠르다.
- 직관적인 API를 제공하고 있어 사용성이 좋다.
- 외부 라이브러리긴 하지만 MongoDB가 관리하고 있어 신뢰성이 높다.
- 문서 정리가 잘 되어있고 커뮤니티가 잘 생성되어있어 정보 습득이 빠르다.
- SPM을 지원한다.
- Entity Mapping할 때 CoreData보다 훨씬 편하다.
-> CoreData는 객체 생성 시 context가 필요하다.

#### 4. 리모트데이터 - Firebase
iCloud와 Firebase 중에 고민이 되어 두 가지를 비교해보고 결론적으로 Firebase가 현재 프로젝트에는 더 좋을 것 같다고 판단해서 Firebase로 선택하였습니다.

<img src = "https://hackmd.io/_uploads/H18Ofyvyp.png" width = 80>

- 편의성이 좋다. CoreData와의 연동이 좋다.
코어데이터를 상속받은 클래스 사용
[NSPersistentCloudKitContainer](https://developer.apple.com/documentation/coredata/nspersistentcloudkitcontainer)
- iCloud는 제공이 약하다.
- iCloud 계정을 쓰므로 친구가 되어있으면 저장 위치에 따라 접근 수준을 정할 수 있다.
- 의존성 관리도구 필요없다.
- [CloudKit](https://developer.apple.com/kr/icloud/cloudkit/)

<img src = "https://hackmd.io/_uploads/SyrlGJDy6.png" width = 110>

- 안드로이드랑 같이 공유가 가능하다. (포트폴리오로 좋다)
- 단점은 비싸다.
- 의존성 관리도구 : 코코아팟이나 **SPM**
- 안드로이드 커버나 커리어 → Firebase
- 제공해주는 서비스가 많다. All in One
    - 데이터베이스랑 셋팅이 다 되어있다.
    - 보안 솔루션도 다 설치되어있다.
- 데이터 센터. 서울도 존재한다.
- 기본요건이 아래와 같아서 하위 버전 호환도 문제 없다.
    - Xcode 14.1 이상
    - iOS 11 이상
- 단점: 직접 DB에 접근하니까 보안이 약하다

<br>

## 📚 참고 링크<a id="참고_링크"></a>

- <Img src = "https://hackmd.io/_uploads/Hyyrii91T.png" width="20"/> [Firebase](https://firebase.google.com/?hl=ko)
- <Img src = "https://hackmd.io/_uploads/B1pu3oq1a.png" width="20"/> [Realm 설치](https://www.mongodb.com/docs/realm/sdk/swift/install/#std-label-ios-install)
- [🍎 Apple Docs: CloudKit](https://developer.apple.com/kr/icloud/cloudkit/)
- [🍎 Apple Docs: List](https://developer.apple.com/documentation/swiftui/list)
- [🍎 Apple Docs: ViewModifier](https://developer.apple.com/documentation/swiftui/viewmodifier)
<br>

---

## 👩‍👧‍👧 about TEAM<a id="about_TEAM"></a>

| <Img src = "https://hackmd.io/_uploads/r1elEh5ka.png" width="100"> | 🐬Whales🐬  | https://github.com/WhalesJin |
| :--------: | :--------: | :--------: |
| <Img src = "https://hackmd.io/_uploads/HkTfN2cyp.png" width="100"> | **Minsup** | **https://github.com/agilestarskim** |

- [타임라인 링크](https://github.com/WhalesJin/ios-project-manager/wiki/타임라인)
