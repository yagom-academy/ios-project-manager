# ⏰ 프로젝트 관리 앱

> 프로젝트 기간: 2022.07.04 ~ 2022.07.15 <br>
> 팀원: [marisol](https://github.com/marisol-develop), [OneTool](https://github.com/kimt4580)
> 리뷰어: [Tony](https://github.com/Monsteel)

## 🔎 프로젝트 소개
: Todo, Doing, Done으로 프로젝트를 관리하는 앱

## 📺 프로젝트 실행화면


## 👀 PR
[STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/129)
[STEP 2]()

## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.2.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-15.2-red)]()

## 🔑 키워드
`SwiftUI` `Realm` `Firebase` `CocoaPod`

## 📑 구현내용
- 프로젝트 수행을 위한 다양한 기술 (SQLite, CoreData, iCloud, Dropbox, Firebase, Realm, MongoDB)의 장단점을 비교하여 사용할 기술 선정
- CocoaPod으로 SwiftLint, Realm, Firebase 설치

## 📖 학습한 내용

- Swift Package Manager와 CoCoaPods의 차이 

**Dynamic FrameWork**
<img src = https://i.imgur.com/syk2WY7.png, width = "80%">
- 동시에 여러 프레임워크 혹은 프로그램에서 공유하여 사용하기 때문에 메모리를 효율적으로 사용
- 동적으로 연결되어 있으므로, 전체 빌드를 다시 하지 않아도 새로운 프레임워크 사용이 가능
- Static Linker를 통해 Dynamic Library Reference가 어플리케이션 코드에 들어가고 모듈 호출시 Stack에 있는 Library에 접근하여 사용
> 💡 Xcode에서 Framework를 생성하면 기본적으로 Dynamic Framework로 생성됩니다.

**Static FrameWork**

<img src = https://i.imgur.com/Kl56y1D.png, width = "80%">

- Static Linker를 통해 Static Library 코드가 어플리케이션 코드 내로 들어가 Heap 메모리에 상주
- 따라서 Static Library가 복사되므로, Static Framework를 여러 Framework에서 사용하게 되면 코드 중복이 발생

**결론**
- 번들을 접근할 때는 스스로가 접근하는 것 보단 외부에서 Bundle의 위치를 주입받는 것이 좋으므로, 소스코드가 복사되는 Static Framework 보다는 Dynamic Framework를 사용하는 것이 더 나을듯 하지만, Dynamic Framework의 무분별한 사용은 App Launch Time을 증가시킨다.

**CoCoaPods**
- 기본적으로 모든 dependency를 Static Library로 링크하고로 link하고, build한다.
- Podfile에 `use_frameworks!`를 추가하면 Dynamic Framework Link하고, `use_frameworks! :linkage => :static`를 입력하면, Static FrameWork처럼 Link하고 build가 가능하다.
- 즉 CoCoaPods은 Static FrameWork처럼 사용할 수 도 있고, Dynamic FrameWork처럼도 사용할 수 있다. default는 Dynamic FrameWork이다.


**Swift Package Manager**
- SPM은 link와 build 방법을 설정 할 수 없도록 되어 있으므로, 무조건 Static Library를 사용할 수 밖에 없다.

**Library와 FrameWork**
- 공통점
    - 재사용 가능한 코드의 모음
    - 프로그래밍을 쉽게 할 수 있도록 도와주는 역할
- 차이점
    - Library: 앱의 흐름을 사용자가 직접 제어
    - Framework: 코드를 연결할 수 있는 위치를 제공하고, 필요에 따라 사용자가 연결한 코드를 호출하는 제어 흐름 권한을 갖는다

프레임워크는 정해진 매뉴얼과 룰을 제공하며, 프레임워크를 사용하려면 이 룰을 지켜야 한다.
하지만 라이브러리는 어떤 특정 기능을 구현하기 위해 미리 만들어진 함수의 집합이며, 필요할 때만 자유롭게 사용할 수 있는 `도구`이다.

참조 : 
[Podfile Syntax Reference](https://guides.cocoapods.org/syntax/podfile.html#use_frameworks_bang)
[Building a dynamic modular iOS architecture](https://medium.com/fluxom/building-a-dynamic-modular-ios-architecture-1b87dc31278b)
[Static, Dynamic Framework](https://velog.io/@dvhuni/Static-Dynamic-Framework)
[프레임워크와 라이브러리 차이점 쉽게 이해하기](https://velog.io/@nemo/framework-library-gfreqbgx)

## 🚀 trouble shooting

### 📌 IPHONEOS_DEPLOYMENT_TARGET Error

marisol은 `IPHONEOS_DEPLOYMENT_TARGET = 15.2;`
OneTool은 `IPHONEOS_DEPLOYMENT_TARGET = 15.5;`
으로 인하여, marisol의 Xcode에서 Simulator들을 사용할 수 없는 일이 발생하였고, 공통으로 `15.2`로 변경하여 Target을 맞춰 주었습니다.

### 📌 M1과 Intel의 FrameWork 설치 오류
서로의 아키텍처가 달라서, SwiftLint 오류가 발생하였고, `cocoapods`으로 `arch -x86_64 pod install`를 사용하여 `pod install` 해주었습니다.



