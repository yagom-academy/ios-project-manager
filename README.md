# 프로젝트 관리 앱 README

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


## 기능 구현
- Rx를 이용해 데이터 화면에 표시

## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.2-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.6-skyblue)]()
- [![xcode](https://img.shields.io/badge/SwiftLint-red)]()

## 저장소 선택
아직 구현단계는 아니지만 추후 구현하게 될 저장소에 대해 아래와 같은 고민을 하였음

### 로컬 저장소
일단 로컬 저장소는 `CoreData`와 `Realm` 둘 사이에서 고민을 하다 `Realm`으로 선택을 하게 되었는데 
가장 큰 이유는 세 가지임
1. iOS와 Android를 모두 지원해 두 플랫폼간 호환이 가능하다
2. Realm이 속도가 더 빠르다
3. CoreData는 사용을 해봤기에 처음 접해보는 Realm을 사용해 보고 싶음

위와 같은 이유로 로컬 저장소는 `Realm`을 선택


### 원격 저장소
원격 저장소는 가장 많이 알려진 `Firebase`, `iCloud`, `Dropbox` 이 세가지 중에서 고민을 했었는데

로컬저장소와 마찬가지로 Android와의 호환성을 위해 `iCloud`는 제외하였고 `Dropbox`의 경우에는 자료를 찾아보기가 생각보다 힘들어서 `Firebase`를 선택하게 되었음

#### Realtime Database vs  Cloud Firestore
`Firebase`내에서도 두 가지 데이터 베이스가 존재하였는데 이번 `프로젝트 관리 앱`같은 경우는 대용량 데이터를 주고받을 일이 없기도 하고 일단 `Firebase`홈페이지에
![](https://i.imgur.com/wjCcxwx.png)
이런 내용이 있기도 했고 아래 고려사항 체크도 해보니 `Realtime Database`가 더 적합한 것으로 확인되어 선택하게 되었음


## Trouble Shooting
### 1. 뷰컨트롤러에 구성 vs 뷰 생성후 뷰컨트롤러에서 사용
mvvm 패턴을 구현함에 있어 viewcontroller도 뷰의 역할을 하도록 하려고 했는데 지금 
`MainView`처럼 뷰컨트롤러에서 뷰구성을 다 하는게 좋을지 
아니면 `DetailView`처럼 뷰를 만들고 그 뷰를 뷰컨트롤러에서 가져와 쓰면서 추가적으로 구성을 해야하는 경우가 있다면 그럴때만 뷰컨트롤러에서 만들면 좋을지
(ex mainviewcontroller의 navigationBar에 접근하기 위해서는 view에서 접근을 못하니 어쩔 수 없이 뷰컨트롤러에서 추가해줘야함) 

이 부분을 가장 고민을 많이 했는데 아직 어떤게 더 좋을 지 기준이 서지 않아 해결 필요

### MockStorage
![](https://i.imgur.com/adnJzRz.png)
아직은 로컬 및 원격 저장소를 구현하기 전이기에 Storageable이라는 프로토콜을 만들어 해당 프로토콜을 준수하는 객체가 저장소가 될 수 있도록(실제 저장소가 생기면 바꿔치기만 할 수 있도록) 구현

### 저장소 공유
MainViewController에서는 read, delete를 DetailViewController에서는 create, update를 하기에 저장소는 공유가 되어야 하는데 세가지 방법 중 고민함

1. detailview를 present할 때 MainViewModel을 주입시킨다
2. storage를 싱글톤으로 구현한다
3. DI Container를 만들어 SceneDelegate에서 MainViewcontroller에 storage를 주입해서 단계별로 주입을 한다

1번같은경우는 detailview또한 viewmodel을 만들어 역할 분리를 하는 것이 맞다고 생각해 제외
2번같은 경우는 저장소를 싱글톤으로 공유하게 된다면 의도치 않은 곳에서 접근할 가능성이 있기에 제외하였으며 3번의 방법을 선택
(물론 이번에 처음 알게된 개념이라 완전한 구현은 어려워 개념은 가져가고 storage주입을 목적으로 약간 따라하는 식으로만 구현)

![](https://i.imgur.com/rz7mZOU.png)

### input/ output

![](https://i.imgur.com/9mieDDw.png)

input은 viewmodel이 이벤트를 받아 해야할 행동
output은 viewmodel이 view로 전달하는 데이터 
정도로 이해를 하고 사용함(추후 더 공부 필요)


## 배운 개념
- RxSwift
- MVVM

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
