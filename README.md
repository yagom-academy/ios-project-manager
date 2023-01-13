# 🗓 프로젝트 매니저

## 📖 목차
1. [소개](#-소개)
2. [파일Tree](#-파일Tree)
3. [타임라인](#-타임라인)
4. [실행 화면](#-실행-화면)
5. [고민한 점](#-고민한-점)
6. [트러블 슈팅](#-트러블-슈팅)
7. [참고 링크](#-참고-링크)

## 🌱 소개

`Mangdi`가 만든 `iPad전용 프로젝트 매니저 앱`입니다.  
TODO, DOING, DONE로 각각 할일, 하고있는 일, 완료한 일 세가지 리스트로 구분되며 사용자가 직접 프로젝트(일)들을 관리할수 있습니다.

## 💻 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()

## 🛒 사용 기술 스택
|UI구현|아키텍처|LocalDB|RemoteDB|의존성관리도구|라이브러리
|:--:|:--:|:--:|:--:|:--:|:--:|
|UIKit|MVC|Realm|Firebase|CocoaPods|SwiftLint|

## 🧑🏻‍💻 팀원
|<img src="https://avatars.githubusercontent.com/u/49121469" width=160>|
|:--:|
|[Mangdi](https://github.com/MangDi-L)|

## 🌲 파일Tree

```
.
├── ProjectManager
│   ├── ProjectManager
│   │   ├── Controller
│   │   │   └── MainViewController.swift
│   │   ├── Info.plist
│   │   ├── Model
│   │   │   └── Assets.xcassets
│   │   │       ├── AccentColor.colorset
│   │   │       │   └── Contents.json
│   │   │       ├── AppIcon.appiconset
│   │   │       │   └── Contents.json
│   │   │       └── Contents.json
│   │   ├── SupportFiles
│   │   │   ├── AppDelegate.swift
│   │   │   └── SceneDelegate.swift
│   │   └── View
│   │       ├── Base.lproj
│   │       │   ├── LaunchScreen.storyboard
│   │       │   └── Main.storyboard
│   │       └── TodoContentView.swift
└── README.md

```
 
## ⏰ 타임라인

### Step 1 타임라인
    
- **23/01/10**
    - 사용할 기술 스택 장단점 비교하며 정하기

- **23/01/11**
    - SwiftLint 적용

___

### Step 2 타임라인
    
- **23/01/12**
    - TodoContentView 구현

- **23/01/13**
    - main화면 UI 구현
    - main화면 UI StackView관련 추가구현
    

## 📱 실행 화면

- STEP 2 실행화면

|실행화면|
|:--:|
|![step2](https://user-images.githubusercontent.com/49121469/212253836-c68576f8-f4c5-403e-bb3d-a00633492434.gif)|
    
</details>

## 👀 고민한 점

### STEP 1

- **아키텍처**
MVVM과 MVC패턴중 어느것을 사용할지 고민했습니다.  
MVC패턴은 이전에도 계속 사용해왔던 방식이라 문제가 없지만 MVVM패턴이란 개념은 처음 접해보았고 바로 적용하는것은 쉽지않아보였습니다.  
그래서 MVC패턴으로 개발하되, MVVM패턴으로 개발하면 구조가 어떻게 될거라는식의 연습을 같이 병행하겠습니다.

- **LocalDB**
CoreData와 Realm 둘중에 어느걸 사용할지 고민했습니다.
    - Realm은 CoreData와 달리 Entity에 대한 매칭을 처리해야할 필요가 없습니다.
    - CoreData는 코드로 데이터를 Read, Write하는 과정이 직관적이지 않아서 불편한점이 있지만 Realm은 직관적인 코드로 작업이 가능합니다.
    - Realm은 Cross Platform을 지원해서 안드로이드OS와 DB파일을 공유할 수 있습니다.
    - Realm은 외부 라이브러리이기때문에 초기 설치 용량(약 14MB)이 필요합니다.
    - 아래 그래프를 보면 Realm이 CoreData보다 2배 더 빠르다는것을 알 수 있습니다.
    ![초당쿼리수비교](https://i.imgur.com/t058Npy.png)
    - Realm은 iOS8 or OS X 10.9 이상이어야 지원합니다. 

    기존에 CoreData를 이용해서 플젝을 진행한 경험이 있어서 CoreData로 진행하려했는데 Realm이란것을 새롭게 알게되어 장단점들을 비교하고 Realm을 사용해보는것도 좋은 경험이 될거라 생각해서 선택하게되었습니다.

- **RemoteDB**
    - Firebase는 google에서 만들었으며, 모든 기기를 지원하는 강력한 장점이 있지만 일반적으로 iOS보단 Android쪽을 더 지원합니다.
    - iCloud는 Apple에서 만들었으며 iOS앱에 강력한 편의 기능을 지원합니다. Android지원은 어렵습니다.

    Firebase와 iCloud 둘 다 좋은 기술이고 하나를 정하기 힘들었습니다.  그래서 iOS 개발자들이 많이 쓰는걸 참고하려고 알아봤는데 Firebase를 많이 사용하는걸 확인했습니다.
![](https://i.imgur.com/PANNszz.png)


- **의존성 관리도구**
    - CocoaPods와 SPM, Carthage 셋 모두 사용하기에 부족함이 없지만 비교적 더 많은 라이브러리를 지원하는 CocoaPods로 정했습니다.

---
    
## ❓ 트러블 슈팅

### STEP 1

X

### STEP 2

- **원하는 스택뷰 그리기**  
UILabel2개로 스택뷰를 구성하여 아래와 같이 구성하고싶었습니다.  
<img width="243" alt="스크린샷 2023-01-13 오후 3 55 21" src="https://user-images.githubusercontent.com/49121469/212256673-069cdb9c-3668-432c-8dea-5b6481512085.png">  
그런데 Hugging과 Compression priority, 등등 스택뷰요소를 아무리 만져도 위 사진과 같이 구성하기가 쉽지 않았습니다.

|삽질의 기록들||
|:--:|:--:|
|<img width="242" alt="스크린샷 2023-01-13 오후 3 57 55" src="https://user-images.githubusercontent.com/49121469/212257081-18a37ec4-65e7-4494-87a3-79bb8228f1c7.png">|<img width="241" alt="스크린샷 2023-01-13 오후 4 03 59" src="https://user-images.githubusercontent.com/49121469/212258096-b0486384-4614-422b-8280-605d01a62e22.png">|

그래서 계속 어떻게 할까 고민하다가 생각해낸게 빈 view를 스택에 추가하는것이었습니다.  
잔머리를 굴린것같지만 그렇게 하면 empty 뷰에 priority를 부여해서 최종적으로 제가 원하던 스택뷰를 그릴 수 있었습니다.


<!-- <details>
<summary> 현재 기기의 Locale 을 확인해서 지역화된 날짜 구현 </summary>
<div markdown="1">

    
</div>
</details> -->

## 🔗 참고 링크


---

[🔝 맨 위로 이동하기](#-일기장-프로젝트)


---
