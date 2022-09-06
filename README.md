# 프로젝트 관리 앱

## 프로젝트 소개
각각의 프로젝트를 관리하는 앱을 생성한다.

> 프로젝트 기간: 2022-09-05 ~ 2022-09-16</br>
> 팀원: [수꿍](https://github.com/Jeon-Minsu), [Hugh](https://github.com/Hugh-github) </br>
리뷰어: [Ryan](https://github.com/ryan-son)</br>


## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [⏱ TimeLine](#-TimeLine)
- [🛠 기술 스택](#-기술-스택)



## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|수꿍|휴|
|:---:|:---:|
|<image src = "https://i.imgur.com/6HkYdmp.png" width="250" height="250">|<image src = "https://i.imgur.com/5oaoHWd.png" width="250" height="250">|
|[수꿍](https://github.com/Jeon-Minsu)|[휴](https://github.com/Hugh-github)|

## ⏱ TimeLine

### Week 1
    
> 2022.09.05 ~ 2022.09.09
    
- 2022.09.05
    - 기술 스택 선정

- 2022.09.06 
    - STEP1 PR

## 기술 스택
### target version
`iOS 14.0`, `iPadOS 14.0`

- iOS 14.0 이상을 사용하는 유저가 전체 유저의 99%를 차지하고 이번 프로젝트에서 async, await 및 sendAction을 통한 button 이벤트 테스트를 하기 위해 target version을 14.0으로 결정했습니다. 

|iOS|iPadOS|
|:---:|:---:|
|<image src = "https://i.imgur.com/MuDZgV0.png" width="200" height="300">|<image src = "https://i.imgur.com/SxroxGG.png" width="200" height="300">|

(출처: https://developer.apple.com/support/app-store/)

### UI
- UIKit
이번 프로젝트에서 MVVM과 테스트 코드에 비중을 두고 진행할 계획이기 때문에 UIKit만을 사용하여 데이터 바인딩을 직접 구현해보는 것이 라이브러리를 사용하기 전에 중요한 경험이 될 것이라고 생각했습니다.

### Architecture
- MVVM
MVC 아키텍처보다는 View를 다루는 로직에 대하여 테스트하기 용이하기 때문에 MVVM 아키텍처를 선택하였습니다.
기회가 된다면 clean architecture 와 coordinator를 적용해 볼 계획입니다.

### 동시성
- Swift Concurrency
이번 프로젝트에서는 rx보다 swift 5.5 이후에 등장한 async await을 이용해 프로젝트를 진행하기로 결정했습니다.
    
### database
- Local : CoreData
    Apple에서 제공하는 first party 기술을 먼저 익히고자 Core Data를 선택했습니다.
    또한, SQLite보다 속도가 빨라 더 만족스러운 UX를 제공할 수 있다고 생각했습니다.
- Remote : Firebase
    Firebase 같은 경우 iOS 10.0 이상부터 사용이 가능합니다.
    NoSQL기반 데이터베이스로 관계형 데이터베이스보다 빠르고 간편합니다.
    또한, 다른 데이터 베이스들과 다르게 RTSP(Real Time Stream Protocol) 방식의 데이터베이스를 지원하고 있기 때문에 소켓 기반 서버를 만들어서 통신하는 것 보다 훨씬 코드 양이 줄게되어 코드 몇 줄로도 원하는 구성을 만들 수 있습니다.

### 의존성 관리도구
- SPM(Swift Package Manager)
