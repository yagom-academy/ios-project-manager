# 🗂 프로젝트 관리

## 🪧 목차
- [📜 프로젝트 및 개발자 소개](#-프로젝트-및-개발자-소개)
- [⚙️ 개발환경 및 라이브러리](#%EF%B8%8F-개발환경-및-라이브러리)
- [⏰ 타임라인](#-타임라인)
- [📱 구현 화면](#-구현-화면)
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
[![swift](https://img.shields.io/badge/swift-5.6-orange)]() [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
<br>


## ⏰ 타임라인

- 22.09.05 ~ 22.09.08 : 프로젝트 기술 선정 
<br>

## 📱 구현 화면
(개발 후 업데이트 예정)
<br>

## 📁 폴더 구조
(개발 후 업데이트 예정)
<br>

## ⚡️ 트러블 슈팅

### 1. 기술 선정 
### LocalDB - CoreData
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

### <br>RemotDB - Firebase
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

`Firestore`가 `RealtimeBase`보다 이후에 나온 데이터베이스로 어느 정도 `RealtimeBase`의 단점을 보완한 상위호환된 버전의 느낌을 받았습니다. 실제로 `Firebase`의 단점으로 빈약한 쿼리가 자주 대두되었는데 `Firestore`는 보다 복잡한 쿼리가 가능합니다. 이외에서 유연한 계층적 데이터 구조를 지원하고, 확장에 보다 열려있습니다.

`RealtimeBase`은 선택한다면 지연 시간을 조금 줄일 수 있고, 규모가 커져도 금액의 상승 폭이 덜 부담된다는 장점이 있습니다. 

하지만 저는 소규모 프로젝트이기 때문에 비용 측면은 고려 대상이 아니고, 지연 시간을 줄이는 것 보다 `Firestore`의 다른 장점을 이용하는 것이 이후 프로젝트에 확장성을 위해서도 좋을 것 같아 최종적으로 `Firestore`을 사용하기로 했습니다.


<br>

## 🔗 참고 링크

<details>
<summary>[STEP 1]</summary>
    
[위키백과-SQLite](https://ko.wikipedia.org/wiki/SQLite)<br>[CoreData와 Realm](https://agilie.com/blog/coredata-vs-realm-what-to-choose-as-a-database-for-ios-apps)<br>[Realm 공식 홈페이지](https://realm.io)<br>[Realm이란 무엇인가?](https://hellominchan.tistory.com/27)<br>[Core Data](https://developer.apple.com/documentation/coredata)<br>[Firebase](https://firebase.google.com/docs/ios/setup?hl=ko)<br>[데이터베이스 선택: Cloud Firestore 또는 실시간 데이터베이스](https://firebase.google.com/docs/database/rtdb-vs-firestore?hl=ko)<br>[Firebase Realtime, Cloud Firestore](https://iamthejiheee.tistory.com/246)
    
</details>

