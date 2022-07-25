# 프로젝트 관리 앱
> 리뷰어: [개굴](https://github.com/yoo-kie)
## 앱 소개
프로젝트를 (해야 할 일, 진행 중인 일, 끝낸 일) 3가지로 나누어 관리하는 앱 입니다.

## TEAM
|iOS|
|:---:|
|[Minseong](https://github.com/Minseong-yagom)|
|<img width="150" src="https://avatars.githubusercontent.com/u/94295586?v=4"/>|

## 프로젝트 기간
> 2022.07.04(월) ~ 07.15(금)
---
## 외부라이브러리
<img src="https://img.shields.io/badge/SwiftLint-F05138?style=flat-square&logo=swift&logoColor=white"/> <img src="https://img.shields.io/badge/Realm-39477F?style=flat-square&logo=realm&logoColor=white"/>
### 외부라이브러리 선택 이유
**SwiftLint**

다른 iOS개발자들과 기본적인 코딩컨벤션을 맞추기 위해 사용하였습니다.

**Realm**

아래와 같은 이유로 사용하였습니다.
- SQLite와 같이 오픈소스며, 모바일에 최적화된 라이브러리
- SQLite, CoreData 보다 속도가 빠르고 성능면에서 더 우수
- 많은 작업들을 처리하기 위해 코드가 많이 필요하지 않음, 메인 스레드에서 데이터의 읽기, 쓰기 작업을 모두 할 수 있기 때문에 보다 편리
- 대용량의 데이터 무료로 사용가능, 용량의 적고 큼에 상관없이 속도와 성능이 유지
---
## 목차
[**1. 실행화면**](#실행화면)  
[**2. 프로젝트 구조**](#프로젝트-구조)  
[**3. 코드 리뷰**](#코드-리뷰)  
[**4. 고민한점**](#고민한점)  
[**5. 트러블 슈팅**](#트러블-슈팅)  
[**6. 키워드**](#키워드)  

---
## 실행화면
작성예정

---
## 프로젝트 구조
작성예정

---
## 코드 리뷰
[STEP1](https://github.com/yagom-academy/ios-project-manager/pull/130), [STEP2](https://github.com/yagom-academy/ios-project-manager/pull/148)

---
## 고민한점
### Realm
**장점**
- SQLite와 같이 오픈소스이며, 모바일에 최적화된 라이브러리
- SQLite, CoreData 보다 속도가 빠르고 성능면에서 더 우수
- 많은 작업들을 처리하기 위해 코드가 많이 필요하지 않음, 메인 스레드에서 데이터의 읽기, 쓰기 작업을 모두 할 수 있기 때문에 보다 편리
- 대용량의 데이터 무료로 사용가능, 용량의 적고 큼에 상관없이 속도와 성능이 유지
- MongoDB Atlas 및 Device Sync를 통한 에지-클라우드 동기화를 지원

**단점**
- 타사 라이브러리를 추가해야 하므로 앱 크기가 증가
- SQLite 및 Firebase에 비해 작은 커뮤니티
### MongoDB
**장점**
- JSON구조로 데이터를 직관적으로 이해 가능
- 사용 방법이 쉽고, 개발이 편리함
- 별도의 스키마 선언 없이 도큐먼트의 필드를 자유롭게 추가 및 삭제할 수 있는 유연한 구조
- 많은 양의 데이터에 대한 Read / Write 성능이 뛰어남
- 빅데이터 처리에 특화

**단점**
- 데이터 업데이트 중 장애 발생 시, 데이터 손실 가능
- MongoDB의 데이터의 유실 가능성 (큰 데이터 모두가 아닌 중간중간 일부 데이터) 
- 많은 인덱스 사용 시, 충분한 메모리 확보 필요
> 장점이 극명하여 단점을 감안하고도 많이 사용한다고 함

---
### 1️⃣ 하위 버전 호환성에는 문제가 없는가?
|MongoDB Realm| 
|:-:|
|XCode 13.1 이상|
|iOS 9 이상|
|Swift Package Manager를 통해 설치하는 경우 iOS 11 이상이 필요|

|iPhone|iPad|
|:---:|:---:|
|<img width="310px" src="https://i.imgur.com/A2mxBmX.png"/>|<img width="315px" src="https://i.imgur.com/ONrcGeB.png"/>|


iOS, ipadOS의 OS 점유율을 확인하였고
하위버전 호환성에 대한 문제가 큰 영향이 없을것이라 판단하였습니다.

---
### 2️⃣ 안정적으로 운용 가능한가?
시장에서 증명된 것이라 안정적으로 운용이 될 것이라 판단하였습니다.

---
### 3️⃣ 미래 지속가능성이 있는가?
MongoDB는 DB-engines에서 랭킹 5등에 위치하고 있고, 회사 규모가 크고 안정적이며 여러 회사를 인수하여 기능 업데이트 등을 많이하고 있는 것으로 보아 지속가능성이 있어보입니다.

---
### 4️⃣ 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
메인스레드를 이용하고 있는데 다른 스레드 접근 시 에러가 발생한다고 합니다.
사용할 때 쓰레드를 지정해줌으로써 위 리스크를 해결하는 것 같습니다.

---
### 5️⃣ 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
Cocoapods을 이용하여 관리할 수 있습니다.

---
### 6️⃣ 이 앱의 요구기능에 적절한 선택인가?
앱의 규모가 작다보니 MongoDB보다 상대적으로 firebase가 좀 더 적절해 보입니다.
하지만 Realm이 MongoDB에 인수되고 DeviceSync를 만들어 Atlas와의 원활한 동기화를  지원한다고 합니다.
이러한 이유로 realm과 MongoDB를 같이 써보고 싶어서 realm 과 MongoDB를 선택하였습니다.

---
## 트러블 슈팅
1️⃣
realmDB에서 데이터를 가져와 cell을 구성하는 과정에서 cell이 구성이 안되는 문제가 발생하였다.
무엇이 문제인지 lldb로 계속 헤메다가 projects의 값이 nil인것을 발견
-> realmdata를 read하는 기능을 실행는 것을 빼먹은 것을 확인
-> read실행 후 projects의 값이 잘 들어왔고 cell구성까지 해결되었다.

2️⃣ 작성중

---
## 키워드
- Composition Layout
- UICollectionView
- 스와이프를 통한 삭제
- Date Picker
- Realm
- MongoDB

---
