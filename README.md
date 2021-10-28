# iOS 커리어 스타터 캠프

## 프로젝트 관리 앱 저장소
프로젝트 기간 (2021.10.25 ~ 2021.11.19)

## Index
* [Step 1](#Step-1)
* [Step 2](#Step-2)

# Step 1
## 적용기술 선정 및 고민 포인트
프로젝트 UI : `SwiftUI Life Cycle`  
LOCAL 데이터 저장 : `CoreData`  
REMOTE 데이터 저장 : `CloudKit`    
의존성 관리 도구 : `SPM : Swift Package Manager`    
외부 라이브러리 : 미정  

- 하위 버전 호환성에는 문제가 없는가?
  > iOS/iPadOS Minimum Availability Version  SwiftUI(13.0 이상) CloudKit(8.0 이상), CoreData(3.0 이상)  
  > SwiftUI가 적용가능한 13.0 이상 버전을 Target Version으로 지정
 
- 안정적으로 운용 가능한가? / 미래 지속가능성이 있는가?
  > 초기 버전으로 매 버전마다 업데이트되는 내용이 많아 유지보수가 필수적일 것으로 예상됨.  
  > SwfitUI와 CloudKit 모두 Apple에서 지원하는 기술이므로 지속 가능성은 긍정적임.

- 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
  > CoreData는 Thread-Safe 하지 않기 떄문에 비동기 동작에 유의 필요함.  
  > 추가될 외부 라이브러리가 SPM을 지원하지 않을 수도 있음.

- 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
  > CoreData와 CloudKit은 First-Party 프레임워크로 애플에서 제공하는 Xcode 자체적으로 사용가능.  
  > 이외의 외부 라이브러리는 SPM만을 사용을 기본으로 진행해보고 필요하다면 CocoaPod, Carthage 사용.

- 이 앱의 요구기능에 적절한 선택인가?
  > 단순 Local 데이터 저장과 Remote 저장소와 동기화를 통해 다른 플랫폼 동시사용 목적.  
  > CoreData와 CloudKit으로 구현 가능할 것으로 예상됨.  
  > 
  > Realm, Firebase, SQLite, Dropbox 등 후보군과 비교할 경험이 부족하기 때문에,  
  > 이번 프로젝트를 통해 CoreData와 CloudKit 경험이 목표.  
  > 다른 라이브러리와 달리 CloudKit은 사용자의 iCloud 계정에 의존함 [관련링크](https://support.apple.com/ko-kr/guide/security/sec3d52c0374/web)
