@@ -1,109 +1,7 @@
# 프로젝트 매니저 Read Me



> 프로젝트 기간: 2022-06-13 ~ 2022-07-01
> 
> 팀원: [우롱차](https://github.com/dnwhd0112), [파프리](https://github.com/papriOS) 
> 
> 리뷰어: [스티븐](https://github.com/stevenkim18)

## 🔎 프로젝트 소개

프로젝트 관리는! 프로젝트 매니저!

## 실행하기전
pod install 해주세요!

## 👀 PR
- [STEP1](https://github.com/yagom-academy/ios-project-manager/pull/121)
- [STEP2]
- [STEP3]

## 🛠 개발환경 및 기술스택
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-14.4-red)]()

|UI구현|local db|remote db|
|------|---|---|
|UIKit|Realm|MongoDB Atlas|


## 타임라인
- [x] 첫째주 : UI구현 및 기술 스택 선택
- [x] 둘째주 : 
- [x] 셋째주 : 

## 프로젝트 구조


## 프로젝트 실행 화면

## 🚀 트러블 슈팅
### STEP1 : 기술스택 선정

### Realm 
| about | 장점 | 단점 |
| --- | --- | --- |
| 빠르고, 반응적이고, 확장이 용이하다.저장, 동기화, 데이터 쿼리ing 을 간단하게 진행할 수 있게 해준다 | 데이터 객체를 Realm에 객체형태로 저장하여 DB에서 가져온 데이터를 가공과정없이 바로 사용할 수 있으며 ORM/DAO가 필요하지 않다.                  MongoDB Atlas와 Device Sync로 클라우드 동기화를 지원한다. 또한 쉽고 믿음직스럽게 앱 퍼포먼스를 낮추지 않고 디바이스에 데이터를 영구저장할 수 있다. | 3rd party 라이브러리 추가로 인해 앱의 크기가 늘어난다. SQLite나 Firebase에 비해 커뮤니티가 작다.          Ream의 sync 기능이 AWS에서만 가능하다. |
### MongoDB Atlas

MongoDB Atlas와 Device Sync로 클라우드 동기화를 지원한다.

---

### 선택 이유와 고려사항

    
#### 1. 하위 버전 호환성에는 문제가 없는가?
#### Realm
| Realm| MongoDB Atlas |
| --- | --- |
|Xcode 11.3 이상,  iOS 9 이상| 해당사항 없음 |


#### 2. 안정적으로 운용 가능한가?
| Realm| MongoDB Atlas |
| --- | --- |
| CoreData 보다 작업속도가 빠르고 Realm Studio를 통해 DB상태를 편하게 확인할 수 있다. MongoDB가 운영하기 때문에 안정적으로 운용 가능하다고 보인다.| Realm을 인수한 MongoDB사에서 만든 멀티 클라우드 애플리케이션 데이터 플랫폼이다. 데이터베이스를 배포 및 관리해주는 역할을 한다. |  



#### 3. 미래 지속가능성이 있는가?

| Realm| MongoDB Atlas |
| --- | --- |
| 최근 MongoDB가 인수하였기에 미래 지속가능성이 높아보인다. | 현재 여러 기업에 서비스를 하는 중임으로 미래 지속 가능성이 높다고 본다. |



#### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

#### Realm

* 멀티스레드 환경에서 Thread safety를 유의해야한다

realm은 `@ThreadSafe Wrapper`, `writeAsync` 등 여러 방법으로 thread safety한 코드를 작성할 수 있도록 지원하고 있다. 
[Realm Threading](https://www.mongodb.com/docs/realm/sdk/swift/advanced-guides/threading/)
[perform a background write](https://www.mongodb.com/docs/realm/sdk/swift/examples/read-and-write-data/#std-label-ios-async-write)

---

#### MongoDB Atlas

파이어 베이스와 비슷한 기능을 제공하는것으로 알고있지만 관련 문서가 너무 적고 사용사례도 적다. Realm과 높은 연동성을 바라보고 사용할 예정이다.
[공식 튜토리얼](https://www.mongodb.com/docs/realm/tutorial/ios-swift/)

#### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
#### Realm
- CocoaPod
- Carthage
- SPM

우리는 `CocoaPod`을 이용하여 관리하였다. 


## ✏️ 학습내용
`Realm`
`MongoDB Atlas`

