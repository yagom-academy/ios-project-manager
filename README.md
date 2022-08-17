# 🗒프로젝트 관리 앱(To Do List)
> 프로젝트 기간 2022-07-04 ~ 2022-07-15

팀원 : [두기](https://github.com/doogie97)
리뷰어 : [TTOzzi](https://github.com/TTOzzi)

## 실행화면

|생성|수정|
|:-:|:-:|
|<img src="https://i.imgur.com/WhqnkEB.gif" width="350" height="230"/>|<img src="https://i.imgur.com/6rnvT2M.gif" width="350" height="230"/>|
|이동|삭제|
|<img src="https://i.imgur.com/QmVBxdd.gif" width="350" height="230"/>|<img src="https://i.imgur.com/y2HHGq2.gif" width="350" height="230"/>|
|로컬저장소|원격저장소|
|<img src="https://user-images.githubusercontent.com/82325822/185056431-9e5d6652-6c44-4817-80c0-f110380d82c8.gif" width="350" height="230"/>|<img src="https://user-images.githubusercontent.com/82325822/185056561-05523b43-1e9c-4f6b-8e50-225364a19197.gif" width="350" height="230"/>|

## 기능 구현
- title, deadline, body로 구성된 Todo List 작성
- Rx를 이용해 데이터 화면에 표시
- Realm을 통해 로컬 저장소에 저장해 어플이 종료되도 작성된 List 유지
- Firebase를 통해 서버에 List백업 기능 구현
- 현재 인터넷 상태를 사용자가 알 수 있도록 UI에 표시

## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.2-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.6-skyblue)]()
- [![swift](https://img.shields.io/badge/Realm-10.28.2-pink)]()
- [![swift](https://img.shields.io/badge/Firebase-9.3.0-yellow)]()
- [![xcode](https://img.shields.io/badge/SwiftLint-red)]()
***

# 📌  저장소 선택
### 로컬 저장소
일단 로컬 저장소는 `CoreData`와 `Realm` 둘 사이에서 고민을 하다 `Realm`으로 선택을 하게 되었는데 
가장 큰 이유는 아래와 같다
1. iOS와 Android를 모두 지원해 두 플랫폼간 호환이 가능하다
2. Realm이 속도가 더 빠르다
3. CoreData는 사용을 해봤기에 처음 접해보는 Realm을 사용해 보고 싶음

위와 같은 이유로 로컬 저장소는 `Realm`을 선택


### 원격 저장소
원격 저장소는 가장 많이 알려진 `Firebase`, `iCloud`, `Dropbox` 이 세가지 중에서 고민을 했었는데

로컬저장소와 마찬가지로 Android와의 호환성을 위해 `iCloud`는 제외하였고 `Dropbox`의 경우에는 자료를 찾아보기가 생각보다 힘들어서 `Firebase`를 선택하게 되었다

#### Realtime Database vs  Cloud Firestore
`Firebase`내에서도 두 가지 데이터 베이스가 존재하였는데 이번 `프로젝트 관리 앱`같은 경우는 대용량 데이터를 주고받을 일이 없기도 하고 일단 `Firebase`홈페이지에
![](https://i.imgur.com/wjCcxwx.png)
이런 내용이 있기도 했고 아래 고려사항 체크도 해보니 `Realtime Database`가 더 적합한 것으로 확인되어 선택하게 되었다


## Trouble Shooting
### 📌 1. 뷰컨트롤러에 구성 vs 뷰 생성후 뷰컨트롤러에서 사용
mvvm 패턴을 구현함에 있어 viewcontroller도 뷰의 역할을 하도록 하려고 했는데 지금 
`MainView`처럼 뷰컨트롤러에서 뷰구성을 다 하는게 좋을지 
아니면 `DetailView`처럼 뷰를 만들고 그 뷰를 뷰컨트롤러에서 가져와 쓰면서 추가적으로 구성을 해야하는 경우가 있다면 그럴때만 뷰컨트롤러에서 만들면 좋을지
(ex mainviewcontroller의 navigationBar에 접근하기 위해서는 view에서 접근을 못하니 어쩔 수 없이 뷰컨트롤러에서 추가해줘야함) 

이 부분을 가장 고민을 많이 했는데 아직 어떤게 더 좋을 지 기준이 서지 않아 해결 필요

### 📌 2. MockStorage
![](https://i.imgur.com/adnJzRz.png)
아직은 로컬 및 원격 저장소를 구현하기 전이기에 Storageable이라는 프로토콜을 만들어 해당 프로토콜을 준수하는 객체가 저장소가 될 수 있도록(실제 저장소가 생기면 바꿔치기만 할 수 있도록) 구현

### 📌 3. 저장소 공유
MainViewController에서는 read, delete를 DetailViewController에서는 create, update를 하기에 저장소는 공유가 되어야 하는데 세가지 방법 중 고민

1. detailview를 present할 때 MainViewModel을 주입시킨다
2. storage를 싱글톤으로 구현한다
3. DI Container를 만들어 SceneDelegate에서 MainViewcontroller에 storage를 주입해서 단계별로 주입을 한다

1번같은경우는 detailview또한 viewmodel을 만들어 역할 분리를 하는 것이 맞다고 생각해 제외
2번같은 경우는 저장소를 싱글톤으로 공유하게 된다면 의도치 않은 곳에서 접근할 가능성이 있기에 제외하였으며 3번의 방법을 선택
(물론 이번에 처음 알게된 개념이라 완전한 구현은 어려워 개념은 가져가고 storage주입을 목적으로 약간 따라하는 식으로만 구현)

![](https://i.imgur.com/rz7mZOU.png)

### 📌 4. input/ output

![](https://i.imgur.com/xsAgDge.png)

input은 view가 보내는 이벤트를 받는 메서드
output은 viewmodel이 view로 전달하는 데이터

view의 이벤트에 따라 적절한 output을 연결시키는 것이 중요!

### 📌 5. 저장소에 ListItem 배열 하나 vs 각 타입별로 세 개의 배열
한 배열로 데이터 관리를 하면 관리는 편해지나 불필요한 정렬이 생김(ex. todoList만 업데이트 했는데 doingList, doneList까지 한번에 받아와 다시 화면에 배치하거나 정렬하는 등...)

그래서 각각의 타입마다 배열을 만들어주었으며 이 때 생기는 중복코드를 제거하기 위해 각 타입에 맞는 배열을 반환해주는 메서드 생성

#### 로컬 저장소
![](https://i.imgur.com/atloxdb.png)

![](https://i.imgur.com/2tUT0RE.png)


#### 앱에서 직접적으로 사용되는 Relay
![](https://i.imgur.com/WG376pT.png)

![](https://i.imgur.com/FTySTO7.png)

### 📌 6. 원격 저장소 저장 시점
상시 서버와 소통하면서 지속적으로 연동 vs 특정 시점에만 서버에 요청

전자의 방식으로 구현하게된다면 굳이 로컬 저장소를 쓸 필요가 없을 뿐더러 서버에 지속적으로 데이터를 주고 받아야 한다고 생각해 후자의 방식으로 구현

### 작동 시점

### 1. 어플 최초 실행시
![](https://i.imgur.com/SWrNDBg.png)
UserDefaults의 `lunchedBefore`키를 이용해 최초 실행인지 아닌지를 판단해 서버로부터 데이터를 받아 올 수 있도록 했다

### 2. ListItem 수정시
ListItem의 creat, update, delete 의 모든 수정사항이 생길 경우 원격저장소에 연동할 수 있도록 구현했다

#### 오프라인 저장소
![](https://i.imgur.com/CHLTUb2.png)

firebase홈페이지를 찾아보니 오프라인 저장기능이 있는 것을 확인
작동원리를 보니 인터넷 연결이 되어있지 않을 때 서버에 무언가를 요청할 경우 캐시에 요청 사항을 저장해뒀다가 인터넷에 연결되었을 때 변경사항을 반영한다는 내용이었으며 이에 따라 오프라인 저장 기능 구현

## 배운 개념
- RxSwift
- MVVM
- Realm
- Firebase
- NWPathMonitor

## 커밋 룰
Commit message
커밋 제목은 최대 50자 입력

💎feat : 새로운 기능 구현

✏️chore : 사소한 코드 수정, 내부 파일 수정, 파일 이동 등

🔨fix : 버그, 오류 해결

📝docs : README나 WIKI 등의 문서 개정

♻️refactor : 수정이 있을 때 사용 (이름변경, 코드 스타일 변경 등)

⚰️del : 쓸모없는 코드 삭제

🔬test : 테스트 코드 수정

📱storyboard : 스토리 보드를 수정 했을 때
