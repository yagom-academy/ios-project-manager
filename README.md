
## 기술 스택
|Programming language|UI Frameworks|Internal frameworks|Package management|Tools|Database|Architecture
|------|---|---|---|---|---|---|
|Swift|UIKit|프로젝트 요구사항 확인 후 추가|SPM, CocoaPods|SwiftLint|CoreData, Firebase|MVVM|

앱의 요구사항에 따라 Alamofire, AlignedCollectionView를 사용해 보고 싶습니다..!

## 고민 포인트
- #### 하위 버전 호환성에는 문제가 없는가
    [ios 버전 점유율](https://gs.statcounter.com/ios-version-market-share/mobile-tablet/south-korea/#monthly-202112-202212)
    현재 대부분의 유저가 ios 15.0 버전 이상을 사용중이며,
    pod은 IOS 9이상
    코어데이터는 IOS 3.0 이상,
    SPM을 통한 Firebase사용은 Firebase 8.6.0, IOS 11이상 사용가능하며
    현재 대부분의 프레임워크를 15버전 이상에서 커버가 가능하다고 생각됩니다.

- #### 안정적으로 운용 가능한가
    사용할 프레임워크는 모두 안정적으로 널리 사용되고 있는 것들로 문제 없이 사용가능하다고 생각됩니다
 
- #### 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가
    swiftLint를 사용하여 가독성을 높이고 휴먼에러를 줄이는 방식으로 리스크를 줄이며 xcode instruments를 사용해 앱의 메모리 누수와 성능을 체크해 자원 낭비에 대한 리스크를 줄일 계획입니다.

- #### 어떤 의존성 관리도구를 사용하여 관리할 수 있는가
    Lint와 firebase등 여러 프레임워크들을 지원되는 의존성 관리도구에 맞춰서 적용할 계획입니다. 해서 SPM과 pods를 둘다 사용하려고 생각했습니다.

- #### 이 앱의 요구기능에 적절한 선택인가
    앱의 내부 프레임워크나 다른 라이브러리의 사용은 구체적인 앱의 요구 기능이 공개되면 적절하게 추가할 계획입니다
