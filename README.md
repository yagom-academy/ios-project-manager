# ✍️ 프로젝트매니저 저장소
 
> 프로젝트 기간 2022.07.04 ~ 2022.07.15 </br> 
팀원: [Quokkaaa](https://github.com/Quokkaaa)
리뷰어: [엘림](https://github.com/lina0322)
 
## 🛠 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]() [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]() [![iOS](https://img.shields.io/badge/iOS-15.0-red)]()
 
## 👨‍🔧 기술스택 
기술스택 | Design Pattern | LocalDB | Remote DB | Convention | 
-- | -- | -- | -- | -- |
UIkit | MVVM | Realm | FireBase | SwiftLint | 
 
## ✅ 프로젝트 중 핵심경험
- [ ] UIKit / SwiftUI / RxCocoa 등 선택한 기술을 통한 UI 구현
- [ ] 다양한 기술 중 목적에 맞는 기술선택
- [ ] Word wrapping 방식의 이해
- [ ] 리스트에서 스와이프를 통한 삭제 구현
- [ ] Date Picker를 통한 날짜입력 
 
## 이번 프로젝트 수행시 제약사항
- 코드에 느낌표(!)를 사용하지 않습니다
- UI는 UIKit / SwiftUI / RxCocoa 중 한가지로 구현합니다
- SwiftLint를 활용하여 코드 스타일을 일관성있게 유지합니다
- 아키텍쳐 및 외부 라이브러리 활용은 자율로합니다
단, 리뷰어와 먼저 상의 후 적용해야합니다
- 메서드 내부의 들여쓰기는 한 번으로 제한합니다 
 
## 목차
 
- [프로젝트 소개](#프로젝트-소개) 
 
- [STEP1](#STEP1)
    + [타임라인](#🗓타임라인_1) 
    + [고민한점](#🤔고민한점_1) 
    + [트러블슈팅](#🔥TroubleShooting_1) 
- [STEP2-1](#STEP2-1)
    + [타임라인](#📅타임라인_2-1) 
    + [고민한점](#🤨고민한점_2-1) 
    + [트러블슈팅](#🧨TroubleShooting_2-1) 
  [STEP2-2](#STEP2-1)
    + [타임라인](#📅타임라인_2-2) 
    + [고민한점](#🤨고민한점_2-2) 
    + [트러블슈팅](#🧨TroubleShooting_2-2) 

- [그라운드 룰](#✅ 그라운드 룰)
    + [코딩 컨벤션](#코딩 컨벤션)

---



## [STEP1]

# 🗓타임라인_1
- 월 - db 종류 비교분석 및 선택
- 화 - 곰튀김 강의 시청 및 STEP1 PR
- 수 - MVVM 개념학습 및 STEP2 구상
- 목 - STEP2-1구현
- 금 - STEP2-2(MVVM)으로 리펙토링

# 🤔고민한점_1 ( Local & Remote DB )

- LocalDB
> **Realm** 를 선택했습니다. 이유는 sql과 coreData보다 성능이 좋다는 그래프를 확인했습니다. 그래프 수치상으로는 약 2배정도 빨랏는데요. 얼만큼 차이가 있을진 모르겠으나 이게 데이터를 많이 오고가고 해야할 상황이라면 데이터가져오고 가는게 빠르면빠를 수 록  사용자입장에선 조금이나 더(?) 빠르게 느낄 수 도 있지않을까 판단했습니다.


- Remote DB
> **Firebase**를 선택했습니다. fireBase와 cloudkit, mongoDB정도를 고민해봤었는데요 이 부분에서는 대중적으로 사용하고 구현이 쉽다는 점과 무엇보다 추천을 해주신게 영향이 컸던 것 같습니다. 

# FireBase DB에 대해서
- 하위 버전 호환성에는 문제가 없는가?
 
![스크린샷 2022-07-05 20 46 01](https://user-images.githubusercontent.com/91132536/177320534-235f2b8a-dccd-462f-bc96-c37bdde6f19c.png)


> 공식문서를 확인해보니 iOS는 10 버전 이상, macOS 10.12 이상, tvOS 12, watch OS 6 이상이어야 사용이 가능하다고 확인되는데요 iOS 사용 유저가 iOS이신 분들이 대부분이라서 하위버전에 사용유저걱정은 크게 없어보인다고 생각했습니다.

- 안정적으로 운용 가능한가?
> 사용자 인증하고 보안 규칙을 작성하여 데이터에대한 읽기/ 쓰기 접근을 제한할 수 있고 토큰생성으로 확인을하며 안전하게 저장하는것으로 알고있습니다. 토큰에대해서 얼마나 안전한지까지는 알아보지않았지만 깃허브 같은 큰 기업도 토큰을 사용하기때문에 안전하다고 봐도되지않을까 생각했습니다.

- 미래 지속가능성이 있는가?
> global market시장에서 3번째로 많은것으로 확인했는데요 2014년도에 구글이 성장률을 보고 인수를 했다고 하고 현재도 사용자들이 많이 사용하는것을 보면 그 만큼 사용자가 만족하고 또 유저가많다보면 피드백받고 개선할 수 있는 점(?)도 많지 않을까 생각해봤습니다. 

- 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
> firebase의 단점 중에 제한된 데이터 마이그레이션과 실시간 DB에는 데이터필터링이 없다는 점이 있다고 하더라구요

- 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
> SPM와 CocoaPod을 사용해 관리할 수 있습니다.

- 이 앱의 요구기능에 적절한 선택인가?
> Mongo DB 는 성능이 좋지만 빠르게 성장하는 스타트업같이 확장성이 있는 기업에 적합했고 Cloukit은 유연성과 관리용이, 성능을 위해 설계됬다보니 쿼리 기능이 강력한데 이를 또 잘 사용하지는 않을 것 같았습니다. 그래서 간단한 앱인만큼 구현과 사용이 편한 Firebase 를 사용하기에 적절한 것 같습니다.



# 🍏 Local DB
**storage skill**
> 모바일 앱의 성능을 결정하는 한가지 요소가 검색어에 대한 응답성이다. 응답 속도가 빠를 수록 성능이 향상된다. 성공적인 검색결과는 앱의 데이터를 저장하는데 사용되는 DB효율성에 중요하다.


## 1️⃣ SQLite
- Mac OS-X, iOS, Android, Linux 및 Windows 모두 접근이 가능하다.
- 데이터 저장이 쉽다.
- 여러 스레드에서 안전하게 접근이 가능하다.
- 여러 열이 있는 테이블에 데이터를 쉽게저장한다.
- 서버 사용에 제한이 없다.
    
## 2️⃣ CoreData
**기존의 테이블 데이터방식보다 객체에 더 중점을 두는 방식**
- Objective-C로 내용을 저장한다.
- SQLite비해 더 많은 메모리를 사용한다.
- SQLite비해 저장 공간이 크다.
- SQLite에 비해 레코드 가져오는 응답 속도가 빠르다.


## 3️⃣ Realm렐름
**이전 DB 솔루션보다 더 빠르고 효율적으로 설계되었으며 모바일 DB이다.**

**특징)**
- Objective-C, Swift에서 사용할 수 있으며 iOS 및 Android용으로 설계되었다.
- 많은 레코드와 사용자를 위한 확장성에 적합하다.
- 쿼리를 마이그레이션하여 데이터 검색이 가능함


**장점)**
- CoreData와 SQLite에 비해 설치가 쉽고 작업속도가 빠르다.
- 빠르고 사용하기 쉽다.(CoreData는 10줄의 코드가 필요할때 Realm은 한줄로 동일한 작업을 수행할 수 있다.)
- 서버사용에 제한이 없다.
- 속도와 성능을 위해 자체 지속성엔진에서 작업한다.
- 마이그레이션시 프로퍼티를 내부적으로 관리하므로 지정해줄 필요가없어 클래스 헤더가 최소화된다.


**단점**
- iOS8 또는 OS X 10.9이상이어야 지원이 가능하다.


# Reference
- https://sebastiandobrincu.com/blog/5-reasons-why-you-should-choose-realm-over-coredata
- https://www.cloudbees.com/blog/ios-databases-sqllite-core-data-realm
- https://developer.apple.com/forums/thread/649649
- https://purple-log.tistory.com/13
- https://www.ileafsolutions.com/blog/sqlite-core-data-and-realm-which-one-to-choose-for-ios-database/

# 🍎 Remote DB

## 1️⃣ MongoDB
**개요 NoSQL**
**SQL은 대량의 데이터를 빠른속도로 처리하는게 어렵기때문에 이를 어느정도 대체해주는 몽고디비가 나오게됨**

- Key-Value와 다르게 여러 용도로 사용가능
- json형태를 사용
- join이 필요없도록 데이터 설계를 해야함

**특징)**
- 메모리에 읜존적
- 메모리를 넘을 경우 성능이 급저하됨
- 쌓아놓고 삭제가 없는 경우에 적합함
  - 이벤트 참여내역
  - 로그 데이터
  - 세션
- 트랜젝션이 필요한 금융, 경제, 빌링, 회원정보에는 부적합함 ( 이런경우는 RDBMS )

=> **일관성을 유지해야하고 보완성이 필요한 중요한 정보등의 경우에는 RDBMS를 사용하면된다.**

**장점)**
- DB에 복잡한 Join이 없다.
- 깊고 복잡한 쿼리를 만들 수 있다.
- 간편한 확장
- 구조화되지않은 데이터를 조직화된 방식으로 저장할 수 있다.
- 모든 종류의 문서를 가상으로 조작하거나 모델링이가능하다.
- 사용자친화적이다.


**단점)**
- 데이터 업데이트 중 장애발생시, 데이터 손실 가능성 존재
- 많은 인덱스 사용시, 충분한 메모리 확보필요
- 데이터 공간 소모가 RDBMS에 비해 많음
- 복잡한 Join사용시 성능 제약이 따름
- transactions 지원이 RDBMS대비 미약
- MongoDB불안전성: 데이터의 유실 가능성
  - 데이터양이 많을 경우
    - 일부 데이터 손실 가능성 존재
    - 데이터 분산저장의 비정상적인 동작가능성
    - 비정상 동작가능성

=> **장점이 극명해 단점을 감안하고도 noSQL사용 비율 1위**

## 실제 사용사례
**다양한 장점과 사용사례존재하지만 이상적으로는  진화와 확장성이 빠른 언테넷 및 비즈니스앱에 사용하는게 좋다. 텍스트 관리나 조작하거나 높은 읽기및 올바른 트래픽확장 할때 좋다.**

- 콘텐츠 관리시스템(블로그 댓글저장기능을 제공함)
- 제품 데이터 관리(전자상거래 사이트)
  - 유연한 스키마를 제공해 문서조작이 쉽기때문
- 장바구니를 상요해 사용자의 쇼핑선호도를 유지함
- 실시간 분석 및 운영 인텔리전스

> 그래서 아래와 같은 행동을 취햄
1. Stitch와 같은 서비스 출시
2. Atlas와 같은 현재서비스기능확장
3. Realm인수(2020/4)

> Chart, Stitch, Atlas와 같은 클라우드 쪽에서 다양한 진화를 했으으며 모든 사람이 접근할 수 있어 매우 사용자 친화적이다.


## 질의응담
- 하위 버전 호환성에는 문제가 없는가?
> 공식문서를 참고했을때 버전마다 호환안되는 문제점에대한 해결책들이 적혀있고 호환되지않는 메서드?도 확인해볼 수 있다. 별다른 문제는 없어보임

- 안정적으로 운용 가능한가?
> 모든데이터가 안전하게 저장되는 매우 안전한 DB프로그램이다. 데이터가 암호화되서 저장되며 MongoDB나 다른 사용자를 포함해 누구도 해독할 수 없다. 오직 데이터와함께 전체 데이터베이스는 사용간으한 데이터를 고나리, 저장 및 변경할 수 있는 권한자만 사용할 수 있습니다. 또한 위험을 최소하하기 위해 MongoDB소유자 고객의 민감한 정보를 확인하거나 접근할 수 있는 권한이 없습니다.
 
- 미래 지속가능성이 있는가?
> 많은 회사가 서버리스가 되기시작하며 대부분의 사람들은 클라우드서비스와 호환되는 DB가 필요했다. 이러한 욕구를 총족하기위해 mongoDB는 이러한 요구를 총족시키기 위해 Atlas 및 Charts와 같은 다양한 클라우드 서비스를 출시했지만 AWS한테 밀림
 
- 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
> 2016년 12월과 2017년 3월에 3만개의 DB해킹, 삭제 요청이있었다. 손실바용이 500달러정도였지만 회사평판과 사용자 신뢰를 떨어뜨렸따. 왜 이런일이 발생한걸까? DB는 보안 구현하는 측면에서 거의 수행하지않았고 기본즉시사용가능한 기본값을 사용해 서버 이미지를 완전히 열어 노출시켰었다. MongoDB는 보안 기본값 을 제공해 소스에서 이문제를 완화했지만 여전히 보안취약성 발생여지는 존재해보인다. 여기서의 문제는 MongoDB가 안전하지 못하기때문이 아니라 이미지 및 서버에 대한 보안 프로토콜 구현이 부족하기때문이다.

> 2018년에도 4억4500만개의 레코드가 노출됬었다.

자세한건 https://www.securecoding.com/blog/mongodb-security/ 여길 봐보자.
- 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
> SPM, CocoaPod, Carthage

- 이 앱의 요구기능에 적절한 선택인가?
> 적절한지는 잘 모르겠다. 스타트업같이 확장성과 빠른성장하는데에 적합하다고 하다보니 그런앱과는 거리가 좀 있는것으로 보이긴한다.


## 참고
- [mongoDB에관한 상위 60개의 인터뷰 질문 및 답변](https://www.upgrad.com/blog/mongodb-interview-questions/)
- https://realm.io/best-ios-database/#use-cases-for-iOS-object-oriented-databases
- https://www.upgrad.com/blog/the-future-scope-of-mongodb/
- https://www.upgrad.com/blog/the-future-scope-of-mongodb/



## 2️⃣ firebase
- 구글에서 지원하는 cloud서비스임
- 비관계형이다.

**장점)**
- 빠르고 안정적이며 웹 및 앱 모두 지원
- 자체 호스팅 제공
- 구현이 쉽고 고급 지식이 필요하지않다.
  - json 파실할 필요가 없다.
- 사용유저가 많아 충분한 기술문서를 제공한다.

**단점)**
- 쿼리 기능이 제한되어있다.
  - 실시간 DB에는 데이터필터링 방법이 없다.
- 보안 수준이 높지않다.
- 안드로이드 중심이다.
- 제한된 데이터 마이그레이션

## 3️⃣ Cloudkit
관리 용이 및 유연성, 성능을 위해 설계되었음

**장점)**
- 외부 종속성이 필요없다.(cocoa touch에 포함되어있기때문에 import할 필요가 없다.)
- iCloud계정을 사용하므로 인증을 설정할 필요가 없다.(로그인만하면됨)
- 생성 및 사용시 알림을 자동생성할 수 있다.
- 쿼리 기능이 강력하다.

## reference
https://medium.com/swift-blondie/cloudkit-vs-firebase-cb23d5e923b7

## [STEP2-1]

# 🤨고민한점_2-1
- [MVVM에 대해서 학습한 자료](https://swiftlim.tistory.com/135)
- TableView or CollectionView 둘 중 무엇을 사용할 것인가 ?
  - TableView
    - 장점
      - CollectionView에 비해 단순하며 구현이 쉽다.
      - Swipe기능을 지원한다.
    - 단점
      - Cell 사이 간격을 View를 넣어서 구현해줘야하는 비용이 발생한다.
      - CollectionView에 비해 기능이 유연하지 않다.
  -  CollectionView
      - 장점
        - TableView에 비해 기능이 유연하다.
        - Apple의 기능 업데이트 지원을 계속 받고 있다(안전성).
        - Cell 사이간격을 View를 넣지않고 띄울 수 있다.
    - 단점
        - Swipe기능을 지원하지 않는다.
        - TableView에 비해 복잡(?) 할 수 있고 구현이 어렵(?)다.

> 이러한 점을 봤을때 향후 
> CollectionView에 기능이 유연하다는 점이 사용자에게 더 많은 기능을 지원해줄 수 있다.(기능추가에 유연함)
> Apple의 기능 업데이트 지원이 계속되기때문에 안정감과 기대감이 있다.
> View를 Cell사이에 삽입하지 않아도 된다
> 라는 점들 때문에 CollectionView를 선택하였습니다.

- UI를 어떻게 구성할 것인가 ?

![](https://i.imgur.com/X70RaXO.png)


> CollectionView로 Section 3개를 나눠서 구현해볼 수 있지않을까 ? 라는 생각으로 시도를 했습니다.  처음에는 section별 horizontal scroll기능이 지원되기때문에 vertical로 지원이 되겠지 싶어서 시작했는데 지원을 하지않는 것 같더라구요.. 😭 그래서 단순하게 CollectionView를 담은 View 3개를 horizontal StackView에 쌓는 구조로 구현하였습니다.

- CollectionView에는 serction별 scroll기능이 vertical은 지원이 안되는것일까 ?
> 사용자가 휴대폰을 사용할때 세로로 스크롤하는 거리보다 가로로 스크롤하는 거리가 더 짧고 엄지손가락을 많이사용하기때문에 ? 사용자 입장에서 편하게 구현되도록? 굳이 section별로 vertical로 스크롤을 지원을 안한것같다고 생각했어요 왜냐하면 사용자가 vertical기능을 사용해야한다고하면 apple이 지원하지않을 것같아 보이진않았습니다!

- DataSource or DiffableDataSource 둘 중 무엇을 사용할 것인가 ?
	- DiffableDataSource의 이점
		- 내부의 데이터 값이 변경될때(추가, 삭제, 수정)마다 자동으로 View를 업로드 해준다.
		- 데이터 동기화를 자동으로 해준다.
		- 코드양 축소

> DataSource를 사용했을때 기본적으로 값을 변경하고 view에 할당한 후 reloadData메서드를 계속 실행 해줬어야 했는데 이런 수동적인 관리를 하지않아도된다는 점에서 바로 사용했던것같습니다(약간..이걸 왜 이제알았을까 싶은 ㅜㅜ)

- CollectionView의 swipe기능을 어떻게 처리할 것인지 ?
> 제가 확인해본 바로는 CollectionView의 Swipe기능을 [지원하지않는](https://stackoverflow.com/questions/63655267/how-to-swipe-left-to-delete-a-collectioncell) 걸로 알고있습니다.
그래서 이를 직접 구현할지 또는 'SwipeCellKit' 라이브러리를 사용할지 두 가지선택지에서 직접구현하면 너무좋겠지만 시간도 빠듯했다보니 그냥 라이브러리를 사용했습니다.

# 🧨TroubleShooting_2-1
- cell swipe 시 나오는 view가 cell 뒤에 가려지는 현상 발생 -> cell view에 add하지말고 contentView에 add하면 됨

## [STEP2-2]

# 🤨고민한점_2-2
- Model, View, ViewModel, ViewController의 역할을 어떻게 구분할 것인가?

- **ViewModel의 역할**
	- view한테 input으로 이벤트를 받고 이에 맞게 데이터 값을 가공하여 ouput을 뱉는다.
- **ViewController의 역할**
	- view에서 발생한 이벤트를 viewModel에 알려준다.
	- viewModel이 뱉은 output값을 view에 전달해준다.
	- view의 UI Layout을 잡아준다.
	- 화면 전환을 해준다.
	- Model 값을 변경하는 과정에서 UI값을 사용해야할 때가 있는데 이럴떄는 viewModel이 이역할을 대신 할 순 없으니 VC가 해준다.(ex) view.width를 받아서 이값으로 어떤 값을 뱉어야할때)
- **View의 역할**
	- 이벤트를 받아서 VC에게 전달해준다.
	- viewModel의 변경된 output값을 받아 view에 보여준다.
- **Model의 역할**
	- 네트워크, json, 비즈니스 로직 등 데이터를 캡슐화한다.


- viewModel은 꼭 class여여만하는가? struct를 사용하면 안되는것인가 ?
> 구글링하여 MVVM관련글을 보면 대부분 viewModel을 class로 구현하였는데 구조체는 안되는걸까 궁금했습니다.

- 저는 UIKit을 사용했기때문에 크게 상관은 없었지만 Comnine이나 Rx를 사용한다고하면 기본적으로 @ObservedObject @EnvironmentObject, @StateObject등을 사용하게되는데 이가 class에만 사용할 수 있다는 점

- 추가로 viewModel에 있는 Model 값이 변경이될텐데 이때 구조체일 경우 mutating/recreated가 이루어 져야하고 이럴 경우에는 기본 Model 값이 변경될때마다 viewModel을 다시할당할 필요가 없기에 class로 구현하는게 합리적일 수 있다는 점

- viewModel은 UIKit이 import되지 않아야한다 ?
	- MVVM이 탄생한 배경이 view와의 의존성을 없애고자 만들어졌는데 viewModel에서 view를 사용하게되면 의존성이 생겨 viewModel의 재사용성에 영향을 줄 수 있다는 점
	- UI코드와 독립적인 테스트가 불가합니다.


# 🧨TroubleShooting_2-2

## [STEP2-3]

# 🤨고민한점

# 🧨TroubleShooting


## ✅ 그라운드 룰

#### 
- 오전 7시 ~ 22시 
- 점심시간 12시 30분 ~ 14시
- 저녁시간 6시 ~ 7시

---

### 코딩 컨벤션
#### 1. Swift 코드 스타일
[스타일가이드 컨벤션](https://github.com/StyleShare/swift-style-guide#%EC%A4%84%EB%B0%94%EA%BF%88)

#### 2. 커밋 메시지
#### 2-1. 커밋 Titie 규칙
```
feat: [기능] 새로운 기능 구현.
bug: [버그] 버그 오류 해결.
refactor: [리팩토링] 코드 리팩토링 / 전면 수정이 있을 때 사용합니다
style: [스타일] 코드 형식, 정렬, 주석 등의 변경 (코드 포맷팅, 세미콜론 누락, 코드 자체의 변경이 없는 경우)
test: [테스트] 테스트 추가, 테스트 리팩토링(제품 코드 수정 없음, 테스트 코드에 관련된 모든 변경에 해당)
docs: [문서] 문서 수정 / README나 Wiki 등의 문서 개정.
chore: [환경설정] 코드 수정
file: [파일] 내부 파일 수정
rename: [네이밍] 네밍 수정
```

#### 2-2. 커밋 Body 규칙
- 들여쓰기 한번만 가능
- 현재 시제를 사용, 이전 행동과 대조하여 변경을 한 동기를 포함하는 것을 권장
- 문장형으로 끝내지 않기
- subject와 body 사이는 한 줄 띄워 구분하기
- subject line의 글자수는 50자 이내로 제한하기
- subject line의 마지막에 마침표(.) 사용하지 않기
- body는 72자마다 줄 바꾸기
- body는 어떻게 보다 무엇을, 왜 에 맞춰 작성하기

