# 🗓 프로젝트 관리 앱
# STEP1 - 프로젝트 적용 기술 선정
## 적용 기술
| 데이터 저장 | UI | 아키텍처 | 의존성 관리도구 |
|:--------:|:--------:|:--------:|:--------:|
| 로컬 - Core Data | SwiftUI | MVVM |CocoaPods|
| 리모트 - Firestore |  |  ||

## 기술 선택 이유
- 안정성 및 미래지속성
    - **Core Data**
        - 애플의 First Party Framework로 운용의 안정성과 미래지속성의 보장도가 높음
        - 애플의 다른 Framework, API와 호환성이 더욱 좋음
    - **Firestore**
        - 구글이 2014년 인수한 서비스로,  trivago, duolingo, alibaba 등의 규모 있는 기업과 많은 스타트업에서 사용하고 있는 기술인만큼 안정적인 운용이 가능
        - Third Party 기술로 페이스북의 Parse처럼 firebase 서비스의 사용을 종료할 수 있으므로 지속성을 보장할 순 없지만 현재로서는 지속적인 업데이트가 이루어지고 있어 당분간 안정적인 지속이 가능할 것으로 예상됨
- 앱 기능 적합성
    - 프로젝트 관리 앱의 특성상 향후 이미지, 문서 파일 업로드 등 추가될 데이터 형식과 기능이 많아질 것이며 여러 팀원들의 데이터를 모두 함께 관리해야하므로 localDB로 Core Data를 선택
    - 팀원들과 함께 실시간으로 일정 관리를 하는 앱으로 크로스 플랫폼을 지원하고 데이터의 실시간 반영이 더욱 효율적인 Firebase를 remoteDB로 선택
- 타 기술과의 비교
    - **Core Data vs SQLite**
        - iOS의 localDB로 많이 쓰이는 SQLite는 데이터베이스의 스키마와 쿼리를 직접 구현해야하나 Core Data는 프레임워크가 알아서 구현한다는 이점이 존재
        - SQLite보다 Core Data가 더 많은 저장공간을 차지하지만 더 빠른 속도로 데이터를 가져온다는 점에서 사용자의 앱 사용경험에 더욱 유리함
        - 단순 데이터를 저장하는 SQLite와는 달리 데이터를 객체 단위로 관리하는 Core Data가 더욱 복잡하고 많은 데이터를 처리하기에 적절함
    - **Firebase vs CloudKit**
        - CloudKit은 First Party로서 localDB로 쓰일 Core Data와 호환성이 더욱 높다는 장점이 있지만, 사용자가 iCloud 계정이 있어야만 사용할 수 있음. 반면에 Firebase는 크로스 플랫폼을 지원하며 소셜 로그인도 가능해 다양한 사용자가 있는 경우 더욱 적절함
        - 데이터의 실시간 동기화에 있어 CloudKit보다 Firebase가 더 효율적임
