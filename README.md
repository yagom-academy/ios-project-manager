# 👨🏻‍💼 프로젝트 매니저
> 기간: 2022-09-05 ~ 2022-09-16
> 
> 팀원: [Kiwi](https://github.com/kiwi1023)
> 
> 리뷰어: [태태](https://github.com/uuu1101)

## 최종 기술 스택 📱

|화면구현|비동기처리|LocalDB|RemoteDB|의존성관리도구|
|-|-|-|-|-|
|![](https://i.imgur.com/IRugLYJ.png)|![](https://i.imgur.com/erAvNzW.png)|![](https://i.imgur.com/pt7joDs.png)|![](https://i.imgur.com/JyJLmzh.png)|![](https://i.imgur.com/fHOfzWQ.png)

## 기술 스택 선정 이유 💻

### LocalDB

| |CoreData|
|-|-|
|특징| 1. Persistence 기능은 SQLite에 의해 지원됨 </br> 2. ORM 모델을 추상화한 구조 </br> 3. 앱의 Model layer를 관리하기 위한 Apple의 First-party FrameWork </br> 4. Object에 더 중심을 둠 
|장점|1. 데이터를 객체 (NSManagedObject) 형태로 저장하여 DB에서 가져온 데이터를 앱에 즉시 사용 가능</br>2. SQLite 대비 속도가 빠름</br>3. iOS에서 자체 제공하기 때문에 비교적 안정적임
|단점|1. Thread-unsafe</br>2. 오버헤드 발생 가능</br>3. Android 등 크로스 플랫폼을 지원하지 않음</br>4. SQLite보다 많은 메모리를 사용하고, 더 많은 저장공간이 필요
|선정이유| 라이브러리의 사용보다는 가장 기본적인 DB를 사용하고 싶었고, 러닝커브를 조금이라도 줄이고 싶었다.

### RemoteDB

| |Firebase|
|-|-|
|특징|1. Google에서 제공하는 모바일 앱개발 플랫폼 </br>2. NoSQL DB 라이브러리</br>3. 실시간으로 사용자 간에 데이터를 저장하고 동기화함</br>4. 구조화된 JSON 및 Collection 데이터 처리에 적합
|장점|1. 직관적으로 데이터 베이스 구조 파악이 쉬움</br>2. Android와 공유가 가능</br>3. 다른 DB에 비해 비교적 저렴</br>4. Analytics를 제공하여 다수의 사용자의 앱 사용 패턴에 대한 통계를 확인
|단점|1. Google에서 지원하므로 iOS 보다 Android에 최적화되어 있음 (ex. device testing 등)</br>2. 데이터 저장용량이 제한적임 (무료 최대 1GB)</br>3. 다른 트리의 다른 노드에 대한 참조는 수동으로 관리해야함</br>4. 종종 서버의 응답속도가 느려짐</br>5. 쿼리가 빈약 (or 문이나 Like문 같은 경우 데이터를 모두 받아와서 직접 필터링 해주어야한다.)
|선정이유| 현업에서의 사용 빈도와 안드로이드와의 호환성을 고려했습니다.

---
1. 하위 버전 호환성에는 문제가 없는가?
CoreData는 ios8이상, Firebase는 ios10이상부터 사용가능

2. 안정적으로 운용 가능한가?, 미래 지속가능성이 있는가?
- Firestore: 3백만 개 이상의 어플에서 활용되고 있고, 현재에도 꾸준하게 업데이트 되고 있는 라이브러리
- Coredata: iOS의 first-party DB이기 때문에 애플에서 꾸준한 업데이트를 할 것이라 예상함.

4. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
Cocoapods, SPM, Carthage을 사용할 수 있으나 사용하는 모든 라이브러리가 CocoaPods을 지원하고, 개인적으로도 가장 익숙한 Cocoapods을 선택했습니다
